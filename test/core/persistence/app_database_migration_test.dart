import 'dart:io';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:strick_haekelbuch/core/persistence/app_database.dart';
import 'package:strick_haekelbuch/features/meters/data/drift_meter_repositories.dart';
import 'package:strick_haekelbuch/features/meters/domain/meter_reading.dart';
import '../../support/reading_fixtures.dart';

void main() {
  test(
    'schema 4 migration preserves legacy photos, revisions and hashes',
    () async {
      final temp = await Directory.systemTemp.createTemp('photo_migration_');
      addTearDown(() => temp.delete(recursive: true));
      final file = File('${temp.path}/old.sqlite');
      final original = sampleReading().copyWith(
        photoHistory: [
          ReadingPhotoVersion(
            id: 'old-photo',
            path: '/old.jpg',
            sha256: 'b' * 64,
            source: ReadingSource.gallery,
            addedAt: DateTime.utc(2026, 1, 1),
            ocrRawText: '',
            ocrCandidate: '',
          ),
        ],
      );
      final previous = AppDatabase.withExecutor(NativeDatabase(file));
      await DriftMeterReadingRepository(previous).save(original);
      final revision = ReadingRevision(
        id: 'legacy-revision',
        readingId: original.id,
        changedAt: original.updatedAt,
        reason: 'Altes Foto',
        changes: {
          'Prüfwert des Fotos (SHA-256)': ReadingChange(
            before: 'b' * 64,
            after: original.photoSha256,
          ),
        },
      );
      await DriftMeterReadingRepository(previous).saveRevision(revision);
      await previous.close();
      final upgraded = AppDatabase.withExecutor(
        NativeDatabase(
          file,
          setup: (database) {
            database.execute(
              'ALTER TABLE reading_records DROP COLUMN photos_json',
            );
            database.execute(
              'ALTER TABLE revision_records DROP COLUMN photo_change_json',
            );
            database.execute('PRAGMA user_version = 4');
          },
        ),
      );
      addTearDown(upgraded.close);
      final repository = DriftMeterReadingRepository(upgraded);
      final loaded = (await repository.findById(original.id))!;
      expect(loaded.toJson(), original.toJson());
      expect(loaded.currentPhotos.single.path, original.photoPath);
      expect(loaded.photoHistory.single.id, 'old-photo');
      expect(
        (await repository.loadRevisions(original.id)).single.toJson(),
        revision.toJson(),
      );
      expect(
        (await upgraded.customSelect('PRAGMA user_version').getSingle())
            .read<int>('user_version'),
        5,
      );
    },
  );

  test('schema 3 migration adds dashboard reading indexes', () async {
    final executor = NativeDatabase.memory(
      setup: (database) {
        database.execute('''
CREATE TABLE reading_records (
  meter_id TEXT NOT NULL,
  captured_at_millis INTEGER NOT NULL,
  stored_at_millis INTEGER NOT NULL,
  updated_at_millis INTEGER NOT NULL
)
''');
        database.execute('CREATE TABLE revision_records (id TEXT PRIMARY KEY)');
        database.execute('PRAGMA user_version = 3');
      },
    );
    final database = AppDatabase.withExecutor(executor);
    addTearDown(database.close);

    final rows = await database
        .customSelect(
          "SELECT name FROM sqlite_master WHERE type = 'index' "
          "AND name LIKE 'reading_meter_%_idx' ORDER BY name",
        )
        .get();

    expect(
      rows.map((row) => row.read<String>('name')),
      containsAll(['reading_meter_captured_idx', 'reading_meter_updated_idx']),
    );
  });
}
