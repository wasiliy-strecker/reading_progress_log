import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:strick_haekelbuch/core/integrity/integrity_service.dart';
import 'package:strick_haekelbuch/features/backup/application/encrypted_backup_service.dart';
import 'package:strick_haekelbuch/features/meters/domain/meter.dart';
import 'package:strick_haekelbuch/features/meters/domain/meter_reading.dart';
import 'package:strick_haekelbuch/features/meters/domain/reading_value.dart';

import '../support/fakes.dart';

// Host-only fixture. The app imports it through its regular backup workflow.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const destination = String.fromEnvironment('STORE_DEMO_DIR');
  test(
    'store demo roundtrip preserves projects, ordered photos and hashes',
    () async {
      final root = destination.isEmpty
          ? await Directory.systemTemp.createTemp('sh-store-demo-')
          : await Directory(destination).create(recursive: true);
      if (destination.isEmpty) addTearDown(() => root.delete(recursive: true));
      final meters = MemoryMeterRepository();
      final readings = MemoryReadingRepository();
      const integrity = IntegrityService();
      const projects = [
        (
          id: 'winterset',
          label: 'Winterset',
          type: MeterType.knitting,
          unit: 'Reihen',
          yarn: 'Merinowolle · Salbei & Natur',
          needle: '4,5 mm',
          values: [4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48],
          endDay: 16,
          photos: ['01_stricken_schal.png', '02_stricken_muetze.png'],
          note: 'Schal und passende Mütze. Als Nächstes den Schal verlängern.',
        ),
        (
          id: 'granny',
          label: 'Granny-Decke',
          type: MeterType.crochet,
          unit: 'Runden',
          yarn: 'Baumwolle · Creme & Terrakotta',
          needle: '3,5 mm',
          values: [1, 2, 3, 4, 5, 6],
          endDay: 15,
          photos: ['03_haekeln_granny_square.png'],
          note: 'Sechste Runde fertig. Danach die Fäden vernähen.',
        ),
        (
          id: 'korb',
          label: 'Häkelkörbchen',
          type: MeterType.crochet,
          unit: 'Runden',
          yarn: 'Baumwollkordel · Natur',
          needle: '6 mm',
          values: [2, 4, 6, 8, 10, 12],
          endDay: 14,
          photos: ['04_haekeln_koerbchen.png'],
          note: 'Der Boden ist fertig. Die Seitenwand wächst.',
        ),
      ];
      for (final project in projects) {
        final meter = Meter(
          id: project.id,
          label: project.label,
          type: project.type,
          unit: project.unit,
          meterNumber: project.yarn,
          location: project.needle,
          createdAt: DateTime.utc(2026, 9, 1),
          updatedAt: DateTime.utc(2026, 9, project.endDay, 18),
        );
        await meters.save(meter);
        for (var i = 0; i < project.values.length; i++) {
          final latest = i == project.values.length - 1;
          final at = DateTime.utc(
            2026,
            9,
            project.endDay - project.values.length + 1 + i,
            18,
          );
          final photos = <ReadingPhotoVersion>[];
          if (latest) {
            for (final (index, name) in project.photos.indexed) {
              final file = File(
                'assets/examples/project_photos/$name',
              ).absolute;
              photos.add(
                ReadingPhotoVersion(
                  id: '${project.id}-photo-$index',
                  path: file.path,
                  sha256: await integrity.sha256Bytes(await file.readAsBytes()),
                  source: ReadingSource.gallery,
                  addedAt: at,
                  ocrRawText: '',
                  ocrCandidate: '',
                ),
              );
            }
          }
          var reading = MeterReading(
            id: '${project.id}-${(i + 1).toString().padLeft(2, '0')}',
            meterId: meter.id,
            meter: MeterSnapshot.fromMeter(meter),
            value: ReadingValue.tryParse('${project.values[i]}')!,
            capturedAt: at,
            timezoneOffsetMinutes: 120,
            storedAt: at,
            updatedAt: at,
            source: latest ? ReadingSource.gallery : ReadingSource.manual,
            photoPath: photos.isEmpty ? '' : photos.first.path,
            photoSha256: photos.isEmpty ? '' : photos.first.sha256,
            photos: photos,
            ocrRawText: '',
            ocrCandidate: '',
            manifestSha256: '',
            note: latest ? project.note : '',
          );
          reading = reading.copyWith(
            manifestSha256: await integrity.readingManifestHash(reading),
          );
          await readings.save(reading);
        }
      }
      EncryptedBackupService service(
        MemoryMeterRepository m,
        MemoryReadingRepository r,
        Directory dir,
      ) => EncryptedBackupService(
        meters: m,
        readings: r,
        exports: MemoryEvidenceExportRepository(),
        reminders: NoopMeterReminderRepository(),
        temporaryDirectoryProvider: () async => dir,
        documentsDirectoryProvider: () async => dir,
      );
      final backup = await service(meters, readings, root).create('Demo2026');
      final delivery = await File(
        backup.path,
      ).copy('${root.path}/Demo.shbackup');
      final restoredRoot = await Directory('${root.path}/roundtrip').create();
      final restoredMeters = MemoryMeterRepository();
      final restoredReadings = MemoryReadingRepository();
      await service(
        restoredMeters,
        restoredReadings,
        restoredRoot,
      ).restore(delivery.path, 'Demo2026');
      expect(restoredMeters.items.length, 3);
      expect(restoredReadings.items.length, 24);
      expect(restoredReadings.items.values.where((r) => r.hasPhoto).length, 3);
      expect(
        restoredReadings.items['winterset-12']!.currentPhotos,
        hasLength(2),
      );
      for (final reading in restoredReadings.items.values) {
        final original = readings.items[reading.id]!;
        expect(reading.value.canonical, original.value.canonical);
        expect(reading.capturedAt.isBefore(DateTime.utc(2026, 9, 17)), isTrue);
        expect(reading.ocrRawText, isEmpty);
        expect(reading.ocrCandidate, isEmpty);
        expect(reading.ocrConfidence, isNull);
        expect(
          await integrity.readingManifestHash(reading),
          reading.manifestSha256,
        );
        expect(
          reading.currentPhotos.map((p) => p.id),
          original.currentPhotos.map((p) => p.id),
        );
        expect(reading.photoHistory, isEmpty);
        for (final photo in reading.currentPhotos) {
          expect(
            await integrity.sha256Bytes(await File(photo.path).readAsBytes()),
            photo.sha256,
          );
        }
      }
      for (final meter in restoredMeters.items.values) {
        expect(meter.toJson(), meters.items[meter.id]!.toJson());
      }
    },
  );
}
