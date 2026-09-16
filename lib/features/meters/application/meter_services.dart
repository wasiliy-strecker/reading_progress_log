import 'dart:async';

import 'package:universal_io/io.dart';

import '../../../core/files/evidence_photo_asset_repository.dart';
import '../../../core/files/meter_photo_repository.dart';
import '../../../core/integrity/integrity_service.dart';
import '../../../core/reminders/local_notification_reminder_repository.dart';
import '../../../core/utils/id_generator.dart';
import '../../../core/utils/reading_time.dart';
import '../../evidence/domain/evidence_export.dart';
import '../domain/meter.dart';
import '../domain/meter_reading.dart';
import '../domain/meter_repositories.dart';
import '../domain/reading_value.dart';

class MeterService {
  const MeterService({
    required this.meters,
    required this.readings,
    required this.exports,
    required this.photos,
    required this.reminders,
    this.evidencePhotos = const NoopEvidencePhotoAssetRepository(),
  });

  final MeterRepository meters;
  final MeterReadingRepository readings;
  final EvidenceExportRepository exports;
  final MeterPhotoCaptureRepository photos;
  final MeterReminderRepository reminders;
  final EvidencePhotoAssetRepository evidencePhotos;

  Future<Meter> create({
    required String label,
    required MeterType type,
    required String unit,
    required String meterNumber,
    required String location,
    ReadingReminderSchedule? reminder,
  }) async {
    final now = DateTime.now().toUtc();
    final meter = Meter(
      id: newLocalId('meter'),
      label: label.trim(),
      type: type,
      unit: unit.trim(),
      meterNumber: meterNumber.trim(),
      location: location.trim(),
      createdAt: now,
      updatedAt: now,
      reminder: reminder,
    );
    await meters.save(meter);
    await reminders.schedule(meter);
    return meter;
  }

  Future<void> update(Meter meter) async {
    final updated = meter.copyWith(updatedAt: DateTime.now().toUtc());
    await meters.save(updated);
    await reminders.schedule(
      updated,
      latestReading: _latestReading(await readings.loadForMeter(updated.id)),
    );
  }

  Future<void> delete(String meterId) async {
    if (await reminders.cancel(meterId) == ReminderOperationResult.failed) {
      throw StateError(
        'Die Erinnerung konnte nicht ausgeschaltet werden. Bitte erneut versuchen.',
      );
    }
    final meterReadings = await readings.loadForMeter(meterId);
    final evidenceExports = await exports.loadForMeter(meterId);
    for (final reading in meterReadings) {
      for (final path in reading.allPhotoPaths) {
        await photos.delete(path);
      }
      for (final sha256
          in reading.allPhotoVersions.map((photo) => photo.sha256).toSet()) {
        await evidencePhotos.delete(sha256);
      }
      await readings.delete(reading.id);
    }
    for (final export in evidenceExports) {
      final file = File(export.filePath);
      if (await file.exists()) {
        await file.delete();
      }
      await exports.delete(export.id);
    }
    await meters.delete(meterId);
  }
}

class MeterReadingService {
  const MeterReadingService({
    required this.meters,
    required this.readings,
    required this.exports,
    required this.photos,
    required this.reminders,
    this.integrity = const IntegrityService(),
    this.evidencePhotos = const NoopEvidencePhotoAssetRepository(),
  });

  final MeterRepository meters;
  final MeterReadingRepository readings;
  final EvidenceExportRepository exports;
  final MeterPhotoCaptureRepository photos;
  final MeterReminderRepository reminders;
  final IntegrityService integrity;
  final EvidencePhotoAssetRepository evidencePhotos;

  Future<MeterReading> create({
    required Meter meter,
    required StoredMeterPhoto photo,
    required ReadingValue value,
    required DateTime capturedAt,
    required String note,
  }) {
    if (photo.source == ReadingSource.manual) {
      throw ArgumentError('Ein Foto benötigt eine Kamera- oder Galeriequelle.');
    }
    return _create(
      meter: meter,
      photo: photo,
      value: value,
      capturedAt: capturedAt,
      note: note,
    );
  }

  Future<MeterReading> createWithPhotos({
    required Meter meter,
    String? readingId,
    required List<ReadingPhotoVersion> photos,
    required ReadingValue value,
    required DateTime capturedAt,
    required String note,
  }) => _create(
    meter: meter,
    readingId: readingId,
    value: value,
    capturedAt: capturedAt,
    note: note,
    photoList: photos,
  );

  Future<MeterReading> createManual({
    required Meter meter,
    required ReadingValue value,
    required DateTime capturedAt,
    required String note,
  }) => _create(meter: meter, value: value, capturedAt: capturedAt, note: note);

  Future<MeterReading> _create({
    required Meter meter,
    required ReadingValue value,
    required DateTime capturedAt,
    required String note,
    StoredMeterPhoto? photo,
    List<ReadingPhotoVersion>? photoList,
    String? readingId,
  }) async {
    final currentPhotos =
        photoList ?? [if (photo != null) _photoVersion(photo)];
    _validatePhotos(currentPhotos);
    final first = currentPhotos.firstOrNull;
    value = _validateValue(value);
    final now = storageTimestamp(DateTime.now());
    var reading = MeterReading(
      id: readingId ?? newLocalId('reading'),
      meterId: meter.id,
      meter: MeterSnapshot.fromMeter(meter),
      value: value,
      capturedAt: storageTimestamp(capturedAt),
      timezoneOffsetMinutes: capturedAt.timeZoneOffset.inMinutes,
      storedAt: now,
      updatedAt: now,
      source: first?.source ?? ReadingSource.manual,
      photoPath: first?.path ?? '',
      photoSha256: first?.sha256 ?? '',
      ocrRawText: '',
      ocrCandidate: '',
      ocrConfidence: null,
      photoAddedAt: first?.addedAt,
      photos: List.unmodifiable(currentPhotos),
      note: note.trim(),
      manifestSha256: '',
    );
    reading = reading.copyWith(
      manifestSha256: await integrity.readingManifestHash(reading),
    );
    await readings.save(reading);
    for (final photo in reading.currentPhotos) {
      _prewarmEvidencePhoto(photo);
    }
    await reminders.acknowledge(meter.id);
    await _refreshReminderSummary(meter.id);
    return reading;
  }

  Future<MeterReading> update({
    required MeterReading existing,
    required ReadingValue value,
    required DateTime capturedAt,
    required String note,
    required String reason,
    StoredMeterPhoto? replacementPhoto,
    List<ReadingPhotoVersion>? photos,
  }) async {
    if (replacementPhoto?.source == ReadingSource.manual) {
      throw ArgumentError('Ein Foto benötigt eine Kamera- oder Galeriequelle.');
    }
    if (photos != null && replacementPhoto != null) {
      throw ArgumentError(
        'Fotos und Einzelfoto-Ersatz nicht gleichzeitig übergeben.',
      );
    }
    final nextPhotos =
        photos ??
        (replacementPhoto == null
            ? existing.currentPhotos
            : [
                _photoVersion(replacementPhoto),
                ...existing.currentPhotos.skip(1),
              ]);
    _validatePhotos(nextPhotos);
    final currentById = {
      for (final photo in existing.currentPhotos) photo.id: photo,
    };
    final archivedIds = existing.photoHistory.map((photo) => photo.id).toSet();
    for (final photo in nextPhotos) {
      final previous = currentById[photo.id];
      if (archivedIds.contains(photo.id) ||
          (previous != null &&
              integrity.canonicalJson(previous.toJson()) !=
                  integrity.canonicalJson(photo.toJson()))) {
        throw ArgumentError('Ein geändertes Foto benötigt eine neue Foto-ID.');
      }
    }
    final beforeIds = existing.currentPhotos.map((photo) => photo.id).toList();
    final afterIds = nextPhotos.map((photo) => photo.id).toList();
    final photosChanged =
        beforeIds.length != afterIds.length ||
        beforeIds.indexed.any((entry) => entry.$2 != afterIds[entry.$1]);
    final photoChange = photosChanged
        ? ReadingPhotoChange(beforeIds: beforeIds, afterIds: afterIds)
        : null;
    value = _validateValue(value, existing: existing.value);
    final changedAt = storageTimestamp(DateTime.now());
    final readingTime = storageTimestamp(capturedAt);
    final timeChanged = !readingTime.isAtSameMomentAs(existing.capturedAt);
    final changes = <String, ReadingChange>{};
    if (existing.value.displayText != value.displayText ||
        existing.value.compareTo(value) != 0) {
      changes[currentProgressLabel(existing.meter.unit)] = ReadingChange(
        before: existing.value.displayText,
        after: value.displayText,
      );
    }
    if (timeChanged) {
      changes['Zeitpunkt des Projektstands'] = ReadingChange(
        before: timestampWithOffset(
          existing.capturedAt,
          existing.timezoneOffsetMinutes,
        ),
        after: timestampWithOffset(
          readingTime,
          capturedAt.timeZoneOffset.inMinutes,
        ),
      );
    }
    if (existing.note != note.trim()) {
      changes['Notiz'] = ReadingChange(
        before: existing.note,
        after: note.trim(),
      );
    }
    if (replacementPhoto != null) {
      changes['Prüfwert des Fotos (SHA-256)'] = ReadingChange(
        before: existing.photoSha256,
        after: replacementPhoto.sha256,
      );
      if (existing.source != replacementPhoto.source) {
        changes['Fotoquelle'] = ReadingChange(
          before: existing.source.label,
          after: replacementPhoto.source.label,
        );
      }
    }
    if (changes.isEmpty && !photosChanged) {
      return existing;
    }

    final archivedPhotos = [
      ...existing.photoHistory,
      for (final photo in existing.currentPhotos)
        if (!afterIds.contains(photo.id)) photo,
    ];
    final first = nextPhotos.firstOrNull;
    var updated = existing.copyWith(
      value: value,
      capturedAt: readingTime,
      timezoneOffsetMinutes: timeChanged
          ? capturedAt.timeZoneOffset.inMinutes
          : existing.timezoneOffsetMinutes,
      updatedAt: changedAt,
      source: first?.source ?? ReadingSource.manual,
      photoPath: first?.path ?? '',
      photoSha256: first?.sha256 ?? '',
      ocrRawText: photosChanged ? '' : null,
      ocrCandidate: photosChanged ? '' : null,
      clearOcrConfidence: photosChanged,
      photoAddedAt: first?.addedAt,
      photos: photosChanged ? List.unmodifiable(nextPhotos) : null,
      photoHistory: archivedPhotos,
      note: note.trim(),
      manifestSha256: '',
    );
    updated = updated.copyWith(
      manifestSha256: await integrity.readingManifestHash(updated),
    );
    await readings.updateWithRevision(
      updated,
      ReadingRevision(
        id: newLocalId('revision'),
        readingId: existing.id,
        changedAt: changedAt,
        reason: reason.trim(),
        changes: changes,
        photoChange: photoChange,
      ),
    );
    for (final photo in updated.currentPhotos) {
      if (!beforeIds.contains(photo.id)) _prewarmEvidencePhoto(photo);
    }
    await _refreshReminderSummary(existing.meterId);
    return updated;
  }

  Future<void> delete(MeterReading reading) async {
    final singleExports = (await exports.loadForMeter(reading.meterId)).where(
      (record) =>
          record.kind == EvidenceExportKind.singleReading &&
          record.readingIds.contains(reading.id),
    );
    for (final record in singleExports) {
      final file = File(record.filePath);
      if (await file.exists()) await file.delete();
      await exports.delete(record.id);
    }
    for (final path in reading.allPhotoPaths) {
      await photos.delete(path);
    }
    for (final sha256
        in reading.allPhotoVersions.map((photo) => photo.sha256).toSet()) {
      await evidencePhotos.delete(sha256);
    }
    await readings.delete(reading.id);
    await _refreshReminderSummary(reading.meterId);
  }

  ReadingPhotoVersion _photoVersion(StoredMeterPhoto photo) =>
      ReadingPhotoVersion(
        id: newLocalId('photo_version'),
        path: photo.path,
        sha256: photo.sha256,
        source: photo.source,
        addedAt: storageTimestamp(photo.capturedAt),
        ocrRawText: '',
        ocrCandidate: '',
      );

  void _validatePhotos(List<ReadingPhotoVersion> photos) {
    if (photos.map((photo) => photo.id).toSet().length != photos.length ||
        photos.any(
          (photo) =>
              photo.id.isEmpty ||
              photo.path.isEmpty ||
              photo.sha256.isEmpty ||
              photo.source == ReadingSource.manual,
        )) {
      throw ArgumentError(
        'Fotos benötigen eindeutige IDs, Dateien und eine Fotoquelle.',
      );
    }
  }

  ReadingValue _validateValue(ReadingValue value, {ReadingValue? existing}) {
    if (existing != null &&
        value.displayText == existing.displayText &&
        value.digits == existing.digits &&
        value.scale == existing.scale) {
      return existing;
    }
    final parsed = ReadingValue.tryParseWhole(value.displayText);
    if (parsed == null || value.scale != 0 || parsed.digits != value.digits) {
      throw const FormatException('Bitte eine ganze Zahl ab 0 eingeben.');
    }
    return parsed;
  }

  void _prewarmEvidencePhoto(ReadingPhotoVersion photo) {
    unawaited(
      evidencePhotos
          .prepare(path: photo.path, sha256: photo.sha256)
          .then<void>((_) {}, onError: (_) {}),
    );
  }

  Future<void> _refreshReminderSummary(String meterId) async {
    final meter = await meters.findById(meterId);
    if (meter == null || meter.reminder == null) return;
    await reminders.schedule(
      meter,
      latestReading: _latestReading(await readings.loadForMeter(meterId)),
    );
  }

  Future<MeterReading?> previousReading({
    required String meterId,
    required DateTime capturedAt,
    String? excludingId,
  }) async {
    final items = await readings.loadForMeter(meterId);
    final earlier =
        items
            .where(
              (item) =>
                  item.id != excludingId &&
                  item.capturedAt.isBefore(capturedAt),
            )
            .toList()
          ..sort((a, b) => b.capturedAt.compareTo(a.capturedAt));
    return earlier.firstOrNull;
  }
}

MeterReading? _latestReading(List<MeterReading> readings) {
  if (readings.isEmpty) return null;
  return readings.reduce(
    (left, right) => left.capturedAt.isAfter(right.capturedAt) ? left : right,
  );
}
