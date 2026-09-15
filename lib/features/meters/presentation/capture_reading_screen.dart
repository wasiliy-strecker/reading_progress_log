import 'dart:async';
import 'package:universal_io/io.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/app_providers.dart';
import '../../../app/widgets/app_snack_bar.dart';
import '../../../app/widgets/confirm_dialog.dart';
import '../../../core/files/meter_photo_repository.dart';
import '../domain/meter.dart';
import '../domain/meter_reading.dart';
import '../domain/reading_value.dart';
import 'editable_reading_time_card.dart';

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
  late final MeterPhotoCaptureRepository _photos;
  StoredMeterPhoto? _photo;
  late DateTime _initialCapturedAt;
  late DateTime _capturedAt;
  bool _working = false;
  bool _saved = false;
  bool _discardDialogOpen = false;
  bool _allowPop = false;
  bool _manual = false;

  @override
  void initState() {
    super.initState();
    _initialCapturedAt = DateTime.now();
    _capturedAt = _initialCapturedAt;
    _photos = ref.read(meterPhotoCaptureRepositoryProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) => _recoverLostCapture());
  }

  @override
  void dispose() {
    if (!_saved && _photo != null) {
      unawaited(_photos.delete(_photo!.path));
    }
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
            if (_photo == null && !_manual) ...[
              const _CaptureGuidance(),
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
                label: const Text('Foto aus Galerie'),
              ),
              const SizedBox(height: 12),
              if (_working) ...[
                const SizedBox(height: 20),
                const Center(child: CircularProgressIndicator()),
                const SizedBox(height: 8),
                const Center(child: Text('Foto wird vorbereitet …')),
              ],
            ] else ...[
              if (_photo != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Image.file(
                      File(_photo!.path),
                      fit: BoxFit.contain,
                      errorBuilder: (_, _, _) => const ColoredBox(
                        color: Colors.black12,
                        child: Center(child: Icon(Icons.broken_image_outlined)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${_photo!.source.label} · Foto lokal gespeichert',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _working ? null : _replacePhoto,
                    icon: const Icon(Icons.change_circle_outlined),
                    label: const Text('Neues Foto aufnehmen oder auswählen'),
                  ),
                ),
                const SizedBox(height: 12),
              ],
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
      canPop: _allowPop || (!_hasUnsavedChanges && !_working),
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _handleBack();
      },
      child: scaffold,
    );
  }

  bool get _hasUnsavedChanges =>
      _photo != null ||
      _value.text.trim().isNotEmpty ||
      _note.text.trim().isNotEmpty ||
      _capturedAt != _initialCapturedAt;

  Future<void> _handleBack() async {
    if (_working || _discardDialogOpen) return;
    FocusScope.of(context).unfocus();
    if (!_hasUnsavedChanges) {
      _leaveForm();
      return;
    }

    _discardDialogOpen = true;
    final discard = await confirmDiscardChanges(
      context,
      title: 'Projektstand verwerfen?',
      message:
          'Dein Projektstand und das ausgewählte Foto wurden noch nicht gespeichert.',
      discardLabel: 'Projektstand verwerfen',
    );
    _discardDialogOpen = false;
    if (!mounted || !discard) return;
    await _leaveWithoutGuard();
  }

  Future<void> _leaveWithoutGuard() async {
    setState(() => _allowPop = true);
    await WidgetsBinding.instance.endOfFrame;
    if (mounted) _leaveForm();
  }

  void _leaveForm() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.goNamed('meterDetail', pathParameters: {'id': widget.meterId});
    }
  }

  Future<void> _capture(ReadingSource source) async {
    if (!mounted || _working) return;
    setState(() => _working = true);
    try {
      final photo = await _photos.capture(source);
      if (photo == null) return;
      if (!mounted) {
        await _photos.delete(photo.path);
        return;
      }
      await _processPhoto(photo);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          AppSnackBar(message: 'Foto konnte nicht verarbeitet werden: $error'),
        );
      }
    } finally {
      if (mounted) setState(() => _working = false);
    }
  }

  Future<void> _recoverLostCapture() async {
    if (!mounted || _working) return;
    setState(() => _working = true);
    try {
      final photo = await _photos.recoverLostCapture();
      if (photo == null) return;
      if (!mounted) {
        await _photos.delete(photo.path);
        return;
      }
      await _processPhoto(photo);
    } on Object {
      return;
    } finally {
      if (mounted) setState(() => _working = false);
    }
  }

  Future<void> _processPhoto(StoredMeterPhoto photo) async {
    final old = _photo;
    if (!mounted) {
      await _photos.delete(photo.path);
      return;
    }
    setState(() {
      _photo = photo;
      if (old == null) _capturedAt = photo.capturedAt;
    });
    if (old != null && old.path != photo.path) await _photos.delete(old.path);
  }

  Future<void> _replacePhoto() async {
    FocusScope.of(context).unfocus();
    final source = await showModalBottomSheet<ReadingSource>(
      context: context,
      builder: (context) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: const Text('Neu fotografieren'),
              onTap: () => Navigator.pop(context, ReadingSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Aus Galerie wählen'),
              onTap: () => Navigator.pop(context, ReadingSource.gallery),
            ),
          ],
        ),
      ),
    );
    if (source != null) await _capture(source);
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
    if (!_formKey.currentState!.validate() || (!_manual && _photo == null)) {
      return;
    }
    final value = ReadingValue.tryParseWhole(_value.text)!;
    setState(() => _working = true);
    try {
      final service = ref.read(meterReadingServiceProvider);
      final reading = _manual
          ? await service.createManual(
              meter: meter,
              value: value,
              capturedAt: _capturedAt,
              note: _note.text,
            )
          : await service.create(
              meter: meter,
              photo: _photo!,
              value: value,
              capturedAt: _capturedAt,
              note: _note.text,
            );
      _saved = true;
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
        setState(() => _working = false);
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
            'Merke dir deine aktuelle Reihe oder Runde. Ein Foto hält fest, wie dein Projekt gerade aussieht.',
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
