import 'package:strick_haekelbuch/core/localization/app_locale.dart';
import 'reading_photo_gallery.dart';
import 'package:universal_io/io.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/app_providers.dart';
import '../../../app/widgets/app_snack_bar.dart';
import '../../../app/widgets/confirm_dialog.dart';
import '../../../app/widgets/pdf_export_progress_dialog.dart';
import '../../../core/integrity/integrity_copy.dart';
import '../../../core/utils/formatters.dart';
import '../../evidence/application/evidence_report_service.dart';
import '../../evidence/domain/evidence_export.dart';
import '../../evidence/presentation/evidence_export_card.dart';
import '../../evidence/presentation/evidence_photo_mode_sheet.dart';
import '../domain/meter.dart';
import '../domain/meter_reading.dart';

class ReadingDetailScreen extends ConsumerStatefulWidget {
  const ReadingDetailScreen({super.key, required this.readingId});

  final String readingId;

  @override
  ConsumerState<ReadingDetailScreen> createState() =>
      _ReadingDetailScreenState();
}

class _ReadingDetailScreenState extends ConsumerState<ReadingDetailScreen> {
  bool _exporting = false;
  final Set<String> _deletingExportIds = {};

  @override
  Widget build(BuildContext context) {
    return ref
        .watch(readingByIdProvider(widget.readingId))
        .when(
          loading: () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
          error: (_, _) => Scaffold(
            body: Center(
              child: Text(stringsOf(context).couldNotLoadProgressEntry),
            ),
          ),
          data: (reading) => reading == null
              ? Scaffold(
                  body: Center(
                    child: Text(stringsOf(context).progressEntryNotFound),
                  ),
                )
              : _buildContent(reading),
        );
  }

  Widget _buildContent(MeterReading reading) {
    final exportsAsync = ref.watch(evidenceForMeterProvider(reading.meterId));
    final singleExports = [
      ...?exportsAsync.value?.where(
        (export) =>
            export.kind == EvidenceExportKind.singleReading &&
            export.readingIds.contains(reading.id),
      ),
    ]..sort((left, right) => right.createdAt.compareTo(left.createdAt));
    final availableFiles = <String, bool>{
      for (final export in singleExports)
        export.id: File(export.filePath).existsSync(),
    };
    return Scaffold(
      appBar: AppBar(title: Text(stringsOf(context).progressEntry)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          if (reading.hasPhoto) ...[
            Text(
              stringsOf(
                context,
              ).currentPhotos((reading.currentPhotos.length).toString()),
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            if (reading.currentPhotos.length > 1) ...[
              OutlinedButton.icon(
                onPressed: () => context.pushNamed(
                  'readingEdit',
                  pathParameters: {'id': reading.id},
                ),
                icon: const Icon(Icons.swap_horiz),
                label: Text(
                  stringsOf(context).sortPhotos,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8),
            ],
            ReadingPhotoGallery(photos: reading.currentPhotos),
            const SizedBox(height: 16),
          ],
          Text(
            '${formatReadingValue(reading.value)} ${progressUnitLabel(reading.meter.unit)}',
            style: Theme.of(
              context,
            ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w900),
          ),
          Text('${reading.meter.type.label} · ${reading.meter.label}'),
          const SizedBox(height: 16),
          _ReadingActions(
            onEdit: () => context.pushNamed(
              'readingEdit',
              pathParameters: {'id': reading.id},
            ),
            onDelete: () => _delete(reading),
          ),
          const SizedBox(height: 18),
          _InfoCard(reading: reading),
          const SizedBox(height: 20),
          Text(
            stringsOf(context).savedProjectReports,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          _SinglePdfAction(
            exporting: _exporting,
            onPressed: () => _export(reading),
          ),
          if (singleExports.isNotEmpty) ...[
            const SizedBox(height: 12),
            for (final export in singleExports)
              EvidenceExportCard(
                export: export,
                title: stringsOf(context).projectReportSingleEntry,
                detail:
                    '${currentProgressLabel(reading.meter.unit)}: ${formatReadingValue(reading.value)}\n${export.photoMode.labelFor(export.kind)}',
                fileAvailable: availableFiles[export.id] == true,
                onTap: availableFiles[export.id] != true
                    ? null
                    : () => _openExport(export),
                deleting: _deletingExportIds.contains(export.id),
                onDelete: () => _deleteExport(export),
              ),
          ],
        ],
      ),
    );
  }

  Future<void> _export(MeterReading reading) async {
    if (_exporting) return;
    setState(() => _exporting = true);
    try {
      final photoMode = await showEvidencePhotoModeSheet(
        context,
        kind: EvidenceExportKind.singleReading,
        hasCurrentPhotos: reading.hasPhoto,
      );
      if (photoMode == null || !mounted) return;
      final report = await runWithPdfExportProgress(
        context,
        description: photoMode == EvidencePhotoMode.withoutPhotos
            ? stringsOf(context).preparingTheProgressEntryAndNotesForTheCompact
            : stringsOf(
                context,
              ).preparingCurrentPhotosProgressAndNotesForThePDF,
        operation: () async {
          final revisions = await ref
              .read(meterReadingRepositoryProvider)
              .loadRevisions(reading.id);
          return ref
              .read(evidenceReportServiceProvider)
              .createSingle(
                reading: reading,
                revisions: revisions,
                photoMode: photoMode,
              );
        },
      );
      if (!mounted) return;
      setState(() => _exporting = false);
      await context.pushNamed('evidencePreview', extra: report);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          AppSnackBar(
            message: stringsOf(
              context,
            ).couldNotCreatePDF(userErrorMessage(error)),
          ),
        );
      }
    } finally {
      if (mounted && _exporting) setState(() => _exporting = false);
    }
  }

  Future<void> _openExport(EvidenceExportRecord record) async {
    final file = File(record.filePath);
    if (!await file.exists()) {
      if (mounted) {
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(
          AppSnackBar(message: stringsOf(context).theSavedPDFFileIsMissing),
        );
      }
      return;
    }
    final report = GeneratedEvidenceReport(
      record: record,
      bytes: await file.readAsBytes(),
    );
    if (mounted) await context.pushNamed('evidencePreview', extra: report);
  }

  Future<void> _deleteExport(EvidenceExportRecord record) async {
    if (_deletingExportIds.contains(record.id)) return;
    final confirmed = await confirmDestructiveAction(
      context,
      title: stringsOf(context).deleteProjectReport288,
      message: stringsOf(context).thePDFWillBePermanentlyDeletedFromStrickH,
    );
    if (!confirmed || !mounted) return;
    setState(() => _deletingExportIds.add(record.id));
    try {
      await ref.read(evidenceReportServiceProvider).delete(record);
      ref.invalidate(evidenceForMeterProvider(record.meterId));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          AppSnackBar(message: stringsOf(context).projectReportDeleted),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          AppSnackBar(
            message: stringsOf(
              context,
            ).couldNotDeleteProjectReportPleaseTryAgain,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _deletingExportIds.remove(record.id));
      }
    }
  }

  Future<void> _delete(MeterReading reading) async {
    final confirmed = await confirmDestructiveAction(
      context,
      title: stringsOf(context).deleteProgressEntry,
      message: stringsOf(
        context,
      ).thisEntryItsAttachmentsAndItsIndividualPDFsWill,
    );
    if (!confirmed || !mounted) return;
    try {
      await ref.read(meterReadingServiceProvider).delete(reading);
      if (!mounted) return;
      ref.invalidate(readingByIdProvider(reading.id));
      ref.invalidate(evidenceForMeterProvider(reading.meterId));
      final messenger = ScaffoldMessenger.of(context);
      if (context.canPop()) {
        context.pop();
      } else {
        context.goNamed('meterDetail', pathParameters: {'id': reading.meterId});
      }
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          AppSnackBar(message: stringsOf(context).progressEntryDeleted),
        );
    } catch (_) {
      if (!mounted) return;
      ref.invalidate(evidenceForMeterProvider(reading.meterId));
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          AppSnackBar(
            message: stringsOf(
              context,
            ).couldNotCompletelyDeleteTheProgressEntryPleaseTry,
          ),
        );
    }
  }
}

class _SinglePdfAction extends StatelessWidget {
  const _SinglePdfAction({required this.exporting, required this.onPressed});

  final bool exporting;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      key: const ValueKey('single-pdf-action'),
      color: colors.secondaryContainer.withValues(alpha: 0.55),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.picture_as_pdf_outlined, color: colors.primary),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stringsOf(context).reportForThisProgressEntry,
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      SizedBox(height: 4),
                      Text(pdfPurposeText),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            FilledButton.icon(
              onPressed: exporting ? null : onPressed,
              icon: const Icon(Icons.picture_as_pdf_outlined),
              label: Text(
                stringsOf(context).createProjectReportAsPDF,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReadingActions extends StatelessWidget {
  const _ReadingActions({required this.onEdit, required this.onDelete});

  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OutlinedButton.icon(
          onPressed: onEdit,
          icon: const Icon(Icons.edit_outlined),
          label: Text(stringsOf(context).edit),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            foregroundColor: colors.error,
            side: BorderSide(color: colors.error),
          ),
          onPressed: onDelete,
          icon: const Icon(Icons.delete_outline),
          label: Text(stringsOf(context).deleteProgressEntry299),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.reading});

  final MeterReading reading;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _row(
              stringsOf(context).progressDateAndTime,
              formatDateTime(reading.capturedAt),
            ),
            _row(
              stringsOf(context).source,
              reading.hasPhoto
                  ? reading.currentPhotos
                        .map((photo) => photo.source.label)
                        .toSet()
                        .join(' · ')
                  : ReadingSource.manual.label,
            ),
            if (reading.lowerReadingReason != null)
              _row(
                stringsOf(context).lowerCount301,
                reading.lowerReadingReason!.label,
              ),
            if (reading.note.isNotEmpty)
              _row(stringsOf(context).note, reading.note),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 130, child: Text(label)),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
