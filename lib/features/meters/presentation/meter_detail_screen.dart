import 'package:strick_haekelbuch/core/localization/app_locale.dart';
import 'package:universal_io/io.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/app_providers.dart';
import '../../../app/widgets/app_actions.dart';
import '../../../app/widgets/app_snack_bar.dart';
import '../../../app/widgets/confirm_dialog.dart';
import '../../../app/widgets/pdf_export_progress_dialog.dart';
import '../../../core/integrity/integrity_copy.dart';
import '../../../core/utils/formatters.dart';
import '../../evidence/application/evidence_report_service.dart';
import '../../evidence/domain/evidence_export.dart';
import '../../evidence/presentation/evidence_list_providers.dart';
import '../../evidence/presentation/evidence_photo_mode_sheet.dart';
import '../../evidence/presentation/saved_history_pdfs.dart';
import '../domain/meter.dart';
import '../domain/meter_reading.dart';
import 'meter_visuals.dart';
import 'reading_history_tile.dart';

class MeterDetailScreen extends ConsumerStatefulWidget {
  const MeterDetailScreen({super.key, required this.meterId});

  final String meterId;

  @override
  ConsumerState<MeterDetailScreen> createState() => _MeterDetailScreenState();
}

class _MeterDetailScreenState extends ConsumerState<MeterDetailScreen> {
  static const _historyPreviewSize = 10;

  bool _exporting = false;
  int _historyPdfResetToken = 0;
  final Set<String> _deletingExportIds = {};
  @override
  Widget build(BuildContext context) {
    final meterAsync = ref.watch(meterByIdProvider(widget.meterId));
    return PopScope<void>(
      canPop: context.canPop(),
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) context.goNamed('home');
      },
      child: meterAsync.when(
        loading: () => Scaffold(
          appBar: _appBar(stringsOf(context).project),
          body: const Center(child: CircularProgressIndicator()),
        ),
        error: (_, _) => Scaffold(
          appBar: _appBar(stringsOf(context).project),
          body: Center(child: Text(stringsOf(context).couldNotLoadProject)),
        ),
        data: (meter) => meter == null
            ? Scaffold(
                appBar: _appBar(stringsOf(context).project),
                body: Center(child: Text(stringsOf(context).projectNotFound)),
              )
            : _buildContent(meter),
      ),
    );
  }

  AppBar _appBar(String title) {
    return AppBar(
      leading: BackButton(onPressed: _leaveDetail),
      title: Text(title),
    );
  }

  void _leaveDetail() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.goNamed('home');
    }
  }

  Widget _buildContent(Meter meter) {
    final historyPageAsync = ref.watch(
      meterHistoryPageProvider((
        meterId: meter.id,
        limit: _historyPreviewSize,
        offset: 0,
        query: '',
      )),
    );
    void openMeterEditor() =>
        context.pushNamed('meterEdit', pathParameters: {'id': meter.id});
    void captureReading() =>
        context.pushNamed('captureReading', pathParameters: {'id': meter.id});
    return Scaffold(
      appBar: _appBar(meter.label),
      body: historyPageAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) =>
            Center(child: Text(stringsOf(context).couldNotLoadProgressEntries)),
        data: (page) {
          return ListView.builder(
            padding: EdgeInsets.fromLTRB(
              16,
              8,
              16,
              AppFloatingActionButton.contentBottomPadding(
                context,
                stringsOf(context).recordProgress,
              ),
            ),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemCount: page.readings.length + 2,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _MeterHeader(
                      meter: meter,
                      latestReading: page.latestReading,
                      onTap: openMeterEditor,
                    ),
                    const SizedBox(height: 12),
                    _MeterActions(
                      onEdit: openMeterEditor,
                      onDelete: () => _deleteMeter(meter),
                    ),
                    const SizedBox(height: 18),
                    if (page.totalCount > 0) ...[
                      _HistoryPdfAction(
                        exporting: _exporting,
                        onPressed: () => _exportHistory(meter),
                      ),
                      const SizedBox(height: 10),
                    ],
                    SavedHistoryPdfs(
                      meterId: meter.id,
                      resetPageToken: _historyPdfResetToken,
                      deletingExportIds: _deletingExportIds,
                      onOpen: _openExport,
                      onDelete: _deleteExport,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      stringsOf(context).projectHistory,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    if (page.totalCount > 0) ...[
                      const SizedBox(height: 8),
                      Text(
                        page.totalCount == 1
                            ? stringsOf(context).entryCount(1)
                            : stringsOf(context).ofProgressEntries(
                                (page.readings.length).toString(),
                                (page.totalCount).toString(),
                              ),
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                    const SizedBox(height: 8),
                    if (page.totalCount == 0)
                      _EmptyReadings(onTap: captureReading),
                  ],
                );
              }

              final readingIndex = index - 1;
              if (readingIndex < page.readings.length) {
                final previous = readingIndex + 1 < page.readings.length
                    ? page.readings[readingIndex + 1]
                    : page.olderNeighbor;
                return ReadingHistoryTile(
                  reading: page.readings[readingIndex],
                  previous: previous,
                  showDelta: true,
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (page.totalCount > _historyPreviewSize) ...[
                    const SizedBox(height: 4),
                    OutlinedButton.icon(
                      key: const ValueKey('open-meter-history'),
                      onPressed: () => context.pushNamed(
                        'meterHistory',
                        pathParameters: {'id': meter.id},
                      ),
                      icon: const Icon(Icons.manage_search_outlined),
                      label: Text(stringsOf(context).showAllProgressEntries),
                    ),
                  ],
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: AppFloatingActionButton(
        onPressed: captureReading,
        icon: Icons.add_a_photo_outlined,
        label: stringsOf(context).recordProgress,
      ),
    );
  }

  Future<void> _exportHistory(Meter meter) async {
    if (_exporting) return;
    setState(() => _exporting = true);
    try {
      final repository = ref.read(meterReadingRepositoryProvider);
      // Use the complete export selection, not the ten-entry history preview.
      final readings = await repository.loadForMeter(meter.id);
      if (!mounted) return;
      final photoMode = await showEvidencePhotoModeSheet(
        context,
        kind: EvidenceExportKind.meterHistory,
        hasCurrentPhotos: readings.any((reading) => reading.hasPhoto),
      );
      if (photoMode == null || !mounted) return;
      final report = await runWithPdfExportProgress(
        context,
        description: photoMode == EvidencePhotoMode.withoutPhotos
            ? stringsOf(
                context,
              ).preparingProgressEntriesAndNotesForTheCompactPDF
            : stringsOf(
                context,
              ).preparingProgressEntriesCurrentPhotosAndNotesForThe,
        operation: () async {
          final revisionLists = await Future.wait(
            readings.map((reading) => repository.loadRevisions(reading.id)),
          );
          final revisions = <String, List<ReadingRevision>>{
            for (var index = 0; index < readings.length; index++)
              readings[index].id: revisionLists[index],
          };
          return ref
              .read(evidenceReportServiceProvider)
              .createHistory(
                meter: meter,
                readings: readings,
                revisions: revisions,
                photoMode: photoMode,
              );
        },
      );
      if (!mounted) return;
      setState(() {
        _exporting = false;
        _historyPdfResetToken++;
      });
      ref.invalidate(evidenceExportPageProvider);
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
      ref.invalidate(evidenceFileAvailableProvider(record.filePath));
      if (mounted) {
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
      ref.invalidate(evidenceExportPageProvider);
      ref.invalidate(evidenceFileAvailableProvider(record.filePath));
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

  Future<void> _deleteMeter(Meter meter) async {
    final confirmed = await confirmDestructiveAction(
      context,
      title: stringsOf(context).deleteProject,
      message: stringsOf(
        context,
      ).allProgressEntriesProgressPhotosAndLocallySavedReports,
    );
    if (!confirmed || !mounted) return;
    try {
      await ref.read(meterServiceProvider).delete(meter.id);
      if (!mounted) return;
      final messenger = ScaffoldMessenger.of(context);
      if (context.canPop()) {
        context.pop();
      } else {
        context.goNamed('home');
      }
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(AppSnackBar(message: stringsOf(context).projectDeleted));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          AppSnackBar(
            message: stringsOf(
              context,
            ).couldNotCompletelyDeleteTheProjectPleaseTryAgain,
          ),
        );
    }
  }
}

class _MeterActions extends StatelessWidget {
  const _MeterActions({required this.onEdit, required this.onDelete});

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
          label: Text(stringsOf(context).editProjectReminder),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            foregroundColor: colors.error,
            side: BorderSide(color: colors.error),
          ),
          onPressed: onDelete,
          icon: const Icon(Icons.delete_outline),
          label: Text(stringsOf(context).deleteProject314),
        ),
      ],
    );
  }
}

class _HistoryPdfAction extends StatelessWidget {
  const _HistoryPdfAction({required this.exporting, required this.onPressed});

  final bool exporting;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
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
                        stringsOf(context).projectReportHistory,
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      SizedBox(height: 4),
                      Text(historyPdfPurposeText),
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
                stringsOf(context).createReportForProjectHistory,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MeterHeader extends StatelessWidget {
  const _MeterHeader({
    required this.meter,
    required this.latestReading,
    required this.onTap,
  });

  final Meter meter;
  final MeterReading? latestReading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = meterColor(
      meter.type,
      brightness: Theme.of(context).brightness,
    );
    final latest = latestReading;
    return Card(
      key: ValueKey('meter-summary-${meter.id}'),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: color.withValues(alpha: 0.12),
                    foregroundColor: color,
                    child: Icon(meterIcon(meter.type)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      meter.type.label,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                latest == null
                    ? stringsOf(context).noProgressEntriesYet
                    : '${formatReadingValue(latest.value)} ${progressUnitLabel(latest.meter.unit, quantity: latest.value)}',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w900,
                ),
              ),
              if (latest != null)
                Text(
                  stringsOf(context).lastRecordedOn(
                    (formatDateTime(latest.capturedAt)).toString(),
                  ),
                ),
              const SizedBox(height: 10),
              if (meter.meterNumber.isNotEmpty)
                Text(
                  stringsOf(context).yarn317((meter.meterNumber).toString()),
                ),
              if (meter.location.isNotEmpty)
                Text(
                  stringsOf(
                    context,
                  ).needleOrHookSize318((meter.location).toString()),
                ),
              if (meter.reminder != null)
                Text(
                  stringsOf(
                    context,
                  ).reminder319((_reminderSummary(meter.reminder!)).toString()),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

String _reminderSummary(ReadingReminderSchedule reminder) {
  final time = formatClockTime(reminder.hour, reminder.minute);
  final schedule = switch (reminder.interval) {
    ReminderInterval.minutely => appStrings.everyMinuteDev210,
    ReminderInterval.hourly => appStrings.hourlyFrom(
      (formatDateTime(reminder.startsAt!)).toString(),
    ),
    ReminderInterval.daily => appStrings.dailyAt((time).toString()),
    ReminderInterval.weekly => appStrings.weeklyOnAt(
      (reminderWeekdayLabel(reminder.day)).toString(),
      (time).toString(),
    ),
    ReminderInterval.monthly => appStrings.monthlyOnDayAt(
      (reminder.day).toString(),
      (time).toString(),
    ),
    ReminderInterval.yearly => appStrings.annualReminder(
      formatMonthDay(reminder.month ?? 1, reminder.day),
      time,
    ),
  };
  return reminder.deliveryMode == ReminderDeliveryMode.punctualWithSound
      ? appStrings.onTimeWithSound216((schedule).toString())
      : schedule;
}

class _EmptyReadings extends StatelessWidget {
  const _EmptyReadings({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        key: const ValueKey('empty-readings-action'),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Icon(
                Icons.add_a_photo_outlined,
                size: 44,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 10),
              Text(
                stringsOf(context).noProgressEntryYetEnterYourCurrentRowOr,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      stringsOf(context).recordFirstProgressEntry,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.chevron_right,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
