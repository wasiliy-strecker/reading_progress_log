import 'dart:io';
import 'dart:convert';

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
  const selectedLocale = String.fromEnvironment(
    'STORE_DEMO_LOCALE',
    defaultValue: 'de-DE',
  );
  for (final locale
      in selectedLocale == 'all'
          ? ['de-DE', 'en-US', 'es-ES', 'fr-FR', 'it-IT', 'pt-BR']
          : [selectedLocale]) {
    test(
      '$locale store demo roundtrip preserves projects, ordered photos and hashes',
      () async {
        final root = destination.isEmpty
            ? await Directory.systemTemp.createTemp('sh-store-demo-')
            : await Directory('$destination/$locale').create(recursive: true);
        if (destination.isEmpty) {
          addTearDown(() => root.delete(recursive: true));
        }
        final meters = MemoryMeterRepository();
        final readings = MemoryReadingRepository();
        const integrity = IntegrityService();
        const projects = [
          (
            id: 'winterset',
            type: MeterType.knitting,
            unit: 'Reihen',
            values: [4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48],
            endDay: 16,
            photos: ['01_stricken_schal.png', '02_stricken_muetze.png'],
          ),
          (
            id: 'granny',
            type: MeterType.crochet,
            unit: 'Runden',
            values: [1, 2, 3, 4, 5, 6],
            endDay: 15,
            photos: ['03_haekeln_granny_square.png'],
          ),
          (
            id: 'korb',
            type: MeterType.crochet,
            unit: 'Runden',
            values: [2, 4, 6, 8, 10, 12],
            endDay: 14,
            photos: ['04_haekeln_koerbchen.png'],
          ),
        ];
        final copy =
            jsonDecode(
                  await File(
                    'scripts/store_assets/locales/$locale.json',
                  ).readAsString(),
                )
                as Map<String, dynamic>;
        final localizedProjects = copy['projects'] as List<dynamic>;
        for (final (projectIndex, project) in projects.indexed) {
          final text = (localizedProjects[projectIndex] as List).cast<String>();
          final meter = Meter(
            id: project.id,
            label: text[0],
            type: project.type,
            unit: project.unit,
            meterNumber: text[1],
            location: text[2],
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
                    sha256: await integrity.sha256Bytes(
                      await file.readAsBytes(),
                    ),
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
              note: latest ? text[3] : '',
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
        expect(
          restoredReadings.items.values.where((r) => r.hasPhoto).length,
          3,
        );
        expect(
          restoredReadings.items['winterset-12']!.currentPhotos,
          hasLength(2),
        );
        for (final reading in restoredReadings.items.values) {
          final original = readings.items[reading.id]!;
          expect(reading.value.canonical, original.value.canonical);
          expect(
            reading.capturedAt.isBefore(DateTime.utc(2026, 9, 17)),
            isTrue,
          );
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
}
