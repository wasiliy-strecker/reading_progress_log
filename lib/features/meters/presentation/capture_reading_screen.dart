import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/app_providers.dart';
import '../../../app/widgets/app_snack_bar.dart';
import '../../../app/widgets/confirm_dialog.dart';
import '../../../core/files/meter_photo_repository.dart';
import '../domain/meter.dart';
import '../application/reading_photo_session.dart';
import 'reading_photo_gallery.dart';
import '../domain/meter_reading.dart';
import '../domain/reading_value.dart';
import 'editable_reading_time_card.dart';
import 'project_photo_examples.dart';

class CaptureReadingScreen extends ConsumerStatefulWidget {
  const CaptureReadingScreen({super.key, required this.meterId});

  final String meterId;

  @override
  ConsumerState<CaptureReadingScreen> createState() =>
      _CaptureReadingScreenState();
}

class _CaptureReadingScreenState extends ConsumerState<CaptureReadingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _value = TextEditingController();
  final _note = TextEditingController();
  late final ReadingPhotoSession _photoSession;
  bool _photoEntry = false;
  late DateTime _initialCapturedAt;
  late DateTime _capturedAt;
  bool _saving = false;
  bool get _working => _saving || _photoSession.busy;
  bool _discardDialogOpen = false;
  bool _allowPop = false;
  bool _manual = false;

  @override
  void initState() {
    super.initState();
    _initialCapturedAt = DateTime.now();
    _capturedAt = _initialCapturedAt;
    _photoSession = ReadingPhotoSession(
      route: '/meter/${widget.meterId}/capture',
      repository: ref.read(meterPhotoCaptureRepositoryProvider),
      store: ref.read(photoDraftStoreProvider),
      readings: ref.read(meterReadingRepositoryProvider),
    )..addListener(_photosChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) => _restorePhotoDraft());
  }

  @override
  void dispose() {
    _photoSession.removeListener(_photosChanged);
    unawaited(_photoSession.close().catchError((Object _) {}));
    _value.dispose();
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ref
        .watch(meterByIdProvider(widget.meterId))
        .when(
          loading: () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
          error: (_, _) => const Scaffold(
            body: Center(child: Text('Projekt konnte nicht geladen werden.')),
          ),
          data: (meter) => meter == null
              ? const Scaffold(
                  body: Center(child: Text('Projekt nicht gefunden.')),
                )
              : _buildContent(meter),
        );
  }

  Widget _buildContent(Meter meter) {
    final selectedUnit = meter.unit;

    final scaffold = Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: _handleBack),
        title: const Text('Projektstand erfassen'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          children: [
            if (!_isEnteringReading) ...[
              const _CaptureGuidance(),
              const SizedBox(height: 14),
              ProjectPhotoExamplesButton(enabled: !_working),
              const SizedBox(height: 18),
              FilledButton.icon(
                onPressed: _working
                    ? null
                    : () => setState(() {
                        _manual = true;
                        _initialCapturedAt = DateTime.now();
                        _capturedAt = _initialCapturedAt;
                      }),
                icon: const Icon(Icons.edit_note_outlined),
                label: const Text('Stand eintragen'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _working
                    ? null
                    : () => _capture(ReadingSource.camera),
                icon: const Icon(Icons.photo_camera_outlined),
                label: const Text('Projekt fotografieren'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _working
                    ? null
                    : () => _capture(ReadingSource.gallery),
                icon: const Icon(Icons.photo_library_outlined),
                label: const Text('Fotos aus Galerie'),
              ),
              const SizedBox(height: 12),
              if (_working) ...[
                const SizedBox(height: 20),
                const Center(child: CircularProgressIndicator()),
                const SizedBox(height: 8),
                const Center(child: Text('Foto wird vorbereitet …')),
              ],
            ] else ...[
              ReadingPhotoEditor(
                photos: _photoSession.photos,
                busy: _working,
                progress: _photoSession.progress,
                onCamera: () => _capture(ReadingSource.camera),
                onGallery: () => _capture(ReadingSource.gallery),
                onReplace: _replacePhoto,
                onRemove: _removePhoto,
                onReorder: _reorderPhotos,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _value,
                decoration: InputDecoration(
                  labelText: '${currentProgressLabel(selectedUnit)} *',
                  suffixText: selectedUnit,
                  helperText: 'Trage ein, wo du gerade aufgehört hast.',
                ),
                autofocus: _manual,
                keyboardType: TextInputType.number,
                onChanged: (_) => setState(() {}),
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                validator: (value) =>
                    ReadingValue.tryParseWhole(value ?? '') == null
                    ? 'Bitte eine ganze Zahl ab 0 eingeben.'
                    : null,
              ),
              const SizedBox(height: 12),
              EditableReadingTimeCard(
                value: _capturedAt,
                onPressed: _pickCapturedAt,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _note,
                decoration: const InputDecoration(
                  labelText: 'Notiz',
                  hintText: 'Optional, z. B. mit dem Ärmel begonnen',
                ),
                maxLines: 3,
                onChanged: (_) => setState(() {}),
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
              ),
              const SizedBox(height: 22),
              FilledButton.icon(
                onPressed: _working ? null : () => _save(meter),
                icon: _working
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Icon(
                        _manual ? Icons.save_outlined : Icons.verified_outlined,
                      ),
                label: Text(
                  _manual
                      ? 'Projektstand speichern'
                      : 'Projektstand bestätigen und speichern',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ],
        ),
      ),
    );
    return PopScope<void>(
      canPop: _allowPop || (!_isEnteringReading && !_working),
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _handleBack();
      },
      child: scaffold,
    );
  }

  bool get _isEnteringReading =>
      _manual || _photoEntry || _photoSession.photos.isNotEmpty;

  bool get _hasUnsavedChanges =>
      _photoSession.photos.isNotEmpty ||
      _value.text.trim().isNotEmpty ||
      _note.text.trim().isNotEmpty ||
      _capturedAt != _initialCapturedAt;

  Future<void> _handleBack() async {
    if (_working || _discardDialogOpen) return;
    FocusScope.of(context).unfocus();
    if (!_hasUnsavedChanges) {
      if (_isEnteringReading) {
        await _returnToCaptureOptions();
      } else {
        _leaveForm();
      }
      return;
    }

    _discardDialogOpen = true;
    final discard = await confirmDiscardChanges(
      context,
      title: 'Projektstand verwerfen?',
      message:
          'Dein Projektstand und die ausgewählten Fotos wurden noch nicht gespeichert.',
      discardLabel: 'Projektstand verwerfen',
    );
    _discardDialogOpen = false;
    if (!mounted || !discard) return;
    await _returnToCaptureOptions();
  }

  Future<void> _returnToCaptureOptions() async {
    setState(() => _saving = true);
    try {
      await _photoSession.discard();
      if (!mounted) return;
      _formKey.currentState?.reset();
      setState(() {
        _manual = false;
        _photoEntry = false;
        _value.clear();
        _note.clear();
        _initialCapturedAt = DateTime.now();
        _capturedAt = _initialCapturedAt;
      });
    } on Object {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          AppSnackBar(
            message:
                'Die ungespeicherten Fotos konnten nicht entfernt werden. '
                'Bitte versuche es erneut.',
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _leaveForm() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.goNamed('meterDetail', pathParameters: {'id': widget.meterId});
    }
  }

  void _photosChanged() {
    if (mounted) setState(() {});
  }

  Map<String, dynamic> get _draftFields => {
    'value': _value.text,
    'note': _note.text,
    'capturedAt': _capturedAt.toIso8601String(),
    'initialCapturedAt': _initialCapturedAt.toIso8601String(),
    'manual': _manual,
    'photoEntry': _photoEntry,
  };

  void _showPhotoFailures(PhotoImportResult result) {
    if (!mounted || result.failures.isEmpty) return;
    ScaffoldMessenger.of(context).showSnackBar(
      AppSnackBar(
        message:
            '${result.photos.length} Fotos hinzugefügt. Nicht verarbeitet: ${result.failures.join(', ')}',
      ),
    );
  }

  Future<void> _capture(ReadingSource source, {String? replacementId}) async {
    if (!mounted || _working) return;
    FocusScope.of(context).unfocus();
    final wasEntering = _isEnteringReading;
    try {
      final result = await _photoSession.capture(
        source,
        formFields: _draftFields,
        replacementId: replacementId,
      );
      if (!mounted) return;
      if (result.photos.isNotEmpty) {
        setState(() {
          _photoEntry = true;
          if (!wasEntering) _capturedAt = result.photos.first.capturedAt;
        });
        await _photoSession.rememberFields(_draftFields);
      }
      _showPhotoFailures(result);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          AppSnackBar(
            message: 'Fotos konnten nicht hinzugefügt werden: $error',
          ),
        );
      }
    }
  }

  Future<void> _restorePhotoDraft() async {
    try {
      final result = await _photoSession.restore();
      if (!mounted) return;
      final fields = _photoSession.fields;
      if (fields.isNotEmpty) {
        setState(() {
          _value.text = fields['value'] as String;
          _note.text = fields['note'] as String;
          _capturedAt = DateTime.parse(fields['capturedAt'] as String);
          _initialCapturedAt = DateTime.parse(
            fields['initialCapturedAt'] as String,
          );
          _manual = fields['manual'] as bool;
          _photoEntry =
              (fields['photoEntry'] as bool) || _photoSession.photos.isNotEmpty;
        });
      }
      _showPhotoFailures(result);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          AppSnackBar(
            message:
                'Foto-Zwischenstand konnte nicht wiederhergestellt werden: $error',
          ),
        );
      }
    }
  }

  Future<void> _replacePhoto(ReadingPhotoVersion photo) async {
    final source = await choosePhotoReplacementSource(context);
    if (source != null && mounted) {
      await _capture(source, replacementId: photo.id);
    }
  }

  Future<void> _removePhoto(ReadingPhotoVersion photo) async {
    try {
      await _photoSession.removePhoto(photo.id, _draftFields);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          AppSnackBar(message: 'Foto konnte nicht entfernt werden: $error'),
        );
      }
    }
  }

  Future<void> _reorderPhotos(List<String> ids) async {
    try {
      await _photoSession.reorderPhotos(ids, _draftFields);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          AppSnackBar(
            message: 'Fotoreihenfolge konnte nicht gespeichert werden: $error',
          ),
        );
      }
    }
  }

  Future<void> _pickCapturedAt() async {
    FocusScope.of(context).unfocus();
    final date = await showDatePicker(
      context: context,
      initialDate: _capturedAt,
      firstDate: firstSelectableReadingDate,
      lastDate: lastSelectableReadingDate,
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_capturedAt),
    );
    if (time == null) return;
    setState(() {
      _capturedAt = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future<void> _save(Meter meter) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final value = ReadingValue.tryParseWhole(_value.text)!;
    setState(() => _saving = true);
    try {
      final service = ref.read(meterReadingServiceProvider);
      final reading = await service.createWithPhotos(
        readingId: _photoSession.readingId,
        meter: meter,
        photos: List.of(_photoSession.photos),
        value: value,
        capturedAt: _capturedAt,
        note: _note.text,
      );
      await _photoSession.committed();
      _allowPop = true;
      if (!mounted) return;
      context.pushReplacementNamed(
        'readingDetail',
        pathParameters: {'id': reading.id},
      );
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          AppSnackBar(message: 'Speichern fehlgeschlagen: $error'),
        );
        setState(() => _saving = false);
      }
    }
  }
}

class _CaptureGuidance extends StatelessWidget {
  const _CaptureGuidance();

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hier machst du weiter',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          const Text(
            'Merke dir deine aktuelle Reihe oder Runde. Fotos halten fest, wie dein Projekt gerade aussieht.',
          ),
          const SizedBox(height: 8),
          Text(
            'Deinen Stand trägst du selbst ein. Fotos und Notizen bleiben auf deinem Gerät.',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    ),
  );
}
