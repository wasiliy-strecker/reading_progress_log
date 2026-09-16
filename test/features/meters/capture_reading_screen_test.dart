import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:strick_haekelbuch/features/evidence/presentation/evidence_list_providers.dart';
import 'package:strick_haekelbuch/app/app.dart';
import 'package:strick_haekelbuch/app/app_providers.dart';
import 'package:strick_haekelbuch/core/files/meter_photo_repository.dart';
import 'package:strick_haekelbuch/features/evidence/application/evidence_report_service.dart';
import 'package:strick_haekelbuch/features/evidence/domain/evidence_export.dart';
import 'package:strick_haekelbuch/features/meters/domain/meter.dart';
import 'package:strick_haekelbuch/features/meters/domain/meter_reading.dart';
import 'package:strick_haekelbuch/features/meters/domain/reading_value.dart';

import '../../support/fakes.dart';

void main() {
  testWidgets(
    'lower new reading needs no reason and does not load full history',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(430, 1600));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final meter = Meter(
        id: 'meter_lower_capture',
        label: 'Strom niedriger',
        type: MeterType.knitting,
        unit: 'Reihen',
        createdAt: DateTime.utc(2026, 9, 1),
        updatedAt: DateTime.utc(2026, 9, 1),
      );
      final meters = MemoryMeterRepository()..items[meter.id] = meter;
      final readings = _CountingHistoryReadingRepository();
      readings.items['previous_high'] = MeterReading(
        id: 'previous_high',
        meterId: meter.id,
        meter: MeterSnapshot.fromMeter(meter),
        value: ReadingValue.tryParse('900,0')!,
        capturedAt: DateTime.utc(2026, 9, 8, 10),
        timezoneOffsetMinutes: 120,
        storedAt: DateTime.utc(2026, 9, 8, 10),
        updatedAt: DateTime.utc(2026, 9, 8, 10),
        source: ReadingSource.camera,
        photoPath: '/tmp/previous-high.jpg',
        photoSha256: 'a' * 64,
        ocrRawText: '900,0',
        ocrCandidate: '900,0',
        manifestSha256: 'b' * 64,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            meterRepositoryProvider.overrideWithValue(meters),
            meterReadingRepositoryProvider.overrideWithValue(readings),
            evidenceExportRepositoryProvider.overrideWithValue(
              MemoryEvidenceExportRepository(),
            ),
            meterPhotoCaptureRepositoryProvider.overrideWithValue(
              _FixedPhotoRepository(),
            ),
            meterReminderRepositoryProvider.overrideWithValue(
              NoopMeterReminderRepository(),
            ),
          ],
          child: const MeterReadingLogApp(),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Strom niedriger'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Projektstand erfassen'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Projekt fotografieren'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Grund für niedrigeren'), findsNothing);
      expect(find.textContaining('niedrigeren Stand'), findsNothing);
      expect(find.textContaining('Vorheriger Stand'), findsNothing);
      expect(readings.watchForMeterCalls, 0);

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Aktuelle Reihe *'),
        '123',
      );
      FocusManager.instance.primaryFocus?.unfocus();
      await tester.pumpAndSettle();
      final save = find.text('Projektstand bestätigen und speichern');
      await tester.ensureVisible(save);
      await tester.tap(save);
      await tester.pumpAndSettle();

      final created = readings.items.values.singleWhere(
        (reading) => reading.id != 'previous_high',
      );
      expect(created.value.displayText, '123');
      expect(created.lowerReadingReason, isNull);
      expect(readings.watchForMeterCalls, 0);
    },
  );

  testWidgets(
    'lower correction needs no reason and preserves a historical reason',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(430, 2200));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final meter = Meter(
        id: 'meter_lower_edit',
        label: 'Gas niedriger',
        type: MeterType.crochet,
        unit: 'Runden',
        createdAt: DateTime.utc(2026, 9, 1),
        updatedAt: DateTime.utc(2026, 9, 1),
      );
      final meters = MemoryMeterRepository()..items[meter.id] = meter;
      final readings = _CountingHistoryReadingRepository();
      readings.items['earlier_high'] = MeterReading(
        id: 'earlier_high',
        meterId: meter.id,
        meter: MeterSnapshot.fromMeter(meter),
        value: ReadingValue.tryParse('900,0')!,
        capturedAt: DateTime.utc(2026, 9, 1, 10),
        timezoneOffsetMinutes: 120,
        storedAt: DateTime.utc(2026, 9, 1, 10),
        updatedAt: DateTime.utc(2026, 9, 1, 10),
        source: ReadingSource.camera,
        photoPath: '/tmp/earlier-high.jpg',
        photoSha256: 'a' * 64,
        ocrRawText: '900,0',
        ocrCandidate: '900,0',
        manifestSha256: 'b' * 64,
      );
      readings.items['legacy_lower'] = MeterReading(
        id: 'legacy_lower',
        meterId: meter.id,
        meter: MeterSnapshot.fromMeter(meter),
        value: ReadingValue.tryParse('500,0')!,
        capturedAt: DateTime.utc(2026, 9, 2, 10),
        timezoneOffsetMinutes: 120,
        storedAt: DateTime.utc(2026, 9, 2, 10),
        updatedAt: DateTime.utc(2026, 9, 2, 10),
        source: ReadingSource.camera,
        photoPath: '/tmp/legacy-lower.jpg',
        photoSha256: 'c' * 64,
        ocrRawText: '500,0',
        ocrCandidate: '500,0',
        lowerReadingReason: LowerReadingReason.meterReplacement,
        manifestSha256: 'd' * 64,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            meterRepositoryProvider.overrideWithValue(meters),
            meterReadingRepositoryProvider.overrideWithValue(readings),
            evidenceExportRepositoryProvider.overrideWithValue(
              MemoryEvidenceExportRepository(),
            ),
            meterPhotoCaptureRepositoryProvider.overrideWithValue(
              _FixedPhotoRepository(),
            ),
            meterReminderRepositoryProvider.overrideWithValue(
              NoopMeterReminderRepository(),
            ),
          ],
          child: const MeterReadingLogApp(),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Gas niedriger'));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('reading-card-legacy_lower')));
      await tester.pumpAndSettle();
      expect(find.text('Niedrigerer Stand'), findsOneWidget);
      expect(find.text('Neuer Projektabschnitt'), findsOneWidget);

      await tester.tap(find.text('Korrigieren'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField).first, '400');
      expect(find.textContaining('Grund für niedrigeren'), findsNothing);
      expect(find.textContaining('niedrigeren Stand'), findsNothing);
      expect(readings.watchForMeterCalls, 0);

      final save = find.text('Korrektur protokollieren');
      await tester.ensureVisible(save);
      await tester.tap(save);
      await tester.pumpAndSettle();

      expect(
        readings.items['legacy_lower']?.lowerReadingReason,
        LowerReadingReason.meterReplacement,
      );
      expect(readings.items['legacy_lower']?.value.displayText, '400');
      expect(find.text('Niedrigerer Stand'), findsOneWidget);
      expect(find.text('Neuer Projektabschnitt'), findsOneWidget);
      expect(readings.watchForMeterCalls, 0);
    },
  );

  testWidgets(
    'meter previews ten readings and opens searchable fixed history pages',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(430, 1200));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final meter = Meter(
        id: 'meter_long_history',
        label: 'Strom Langzeit',
        type: MeterType.knitting,
        unit: 'Reihen',
        createdAt: DateTime.utc(2026, 7, 1),
        updatedAt: DateTime.utc(2026, 7, 1),
      );
      final meters = MemoryMeterRepository()..items[meter.id] = meter;
      final readings = MemoryReadingRepository();
      final base = DateTime.utc(2026, 7, 1, 12);
      for (var index = 0; index < 45; index++) {
        final capturedAt = base.add(Duration(days: index));
        readings.items['long_reading_$index'] = MeterReading(
          id: 'long_reading_$index',
          meterId: meter.id,
          meter: MeterSnapshot.fromMeter(meter),
          value: ReadingValue.tryParse('${1000 + index},0')!,
          capturedAt: capturedAt,
          timezoneOffsetMinutes: 120,
          storedAt: capturedAt,
          updatedAt: capturedAt,
          source: ReadingSource.camera,
          photoPath: '/tmp/long_reading_$index.jpg',
          photoSha256: 'a' * 64,
          ocrRawText: '${1000 + index},0',
          ocrCandidate: '${1000 + index},0',
          note: index == 3 ? 'Spezialfund im Heizraum' : '',
          manifestSha256: 'b' * 64,
        );
      }

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            meterRepositoryProvider.overrideWithValue(meters),
            meterReadingRepositoryProvider.overrideWithValue(readings),
            evidenceExportRepositoryProvider.overrideWithValue(
              MemoryEvidenceExportRepository(),
            ),
          ],
          child: const MeterReadingLogApp(),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Strom Langzeit'));
      await tester.pumpAndSettle();

      expect(readings.lastPageLimit, 10);
      expect(readings.lastPageQuery, isEmpty);
      final historyPdfAction = find.text('Projektprotokoll · Projektverlauf');
      final historyTitle = find.text('Projektverlauf');
      expect(historyPdfAction, findsOneWidget);
      expect(
        tester.getTopLeft(historyPdfAction).dy,
        lessThan(tester.getTopLeft(historyTitle).dy),
      );
      expect(find.text('Gespeicherte Projektprotokolle'), findsNothing);
      expect(find.text('10 von 45 Projektständen'), findsOneWidget);
      expect(find.byKey(const ValueKey('history-search-field')), findsNothing);
      final openHistory = find.byKey(const ValueKey('open-meter-history'));
      await tester.scrollUntilVisible(
        openHistory,
        400,
        scrollable: find.byType(Scrollable).last,
      );
      await tester.tap(openHistory);
      await tester.pumpAndSettle();
      expect(readings.lastPageLimit, 10);
      expect(readings.lastPageOffset, 0);
      expect(find.text('1–10 von 45 Projektständen'), findsOneWidget);
      final search = find.byKey(const ValueKey('history-search-field'));
      expect(search, findsOneWidget);

      await tester.enterText(search, 'SPEZIALFUND');
      await tester.pump(const Duration(milliseconds: 249));
      expect(readings.lastPageQuery, isEmpty);
      await tester.pump(const Duration(milliseconds: 2));
      await tester.pumpAndSettle();

      expect(readings.lastPageLimit, 10);
      expect(readings.lastPageQuery, 'SPEZIALFUND');
      expect(find.text('1 Treffer'), findsOneWidget);
      expect(
        find.byKey(const ValueKey('reading-card-long_reading_3')),
        findsOneWidget,
      );
      expect(find.text('Spezialfund im Heizraum'), findsOneWidget);
      expect(find.textContaining('Fortschritt'), findsNothing);

      await tester.tap(find.byTooltip('Suche löschen'));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('history-next-page')));
      await tester.pumpAndSettle();

      expect(readings.lastPageLimit, 10);
      expect(readings.lastPageOffset, 10);
      expect(readings.lastPageQuery, isEmpty);
      expect(find.text('11–20 von 45 Projektständen'), findsOneWidget);
      expect(find.text('Seite 2 von 5'), findsOneWidget);
      expect(
        find.byKey(const ValueKey('reading-card-long_reading_44')),
        findsNothing,
      );
      for (var page = 2; page < 5; page++) {
        await tester.tap(find.byKey(const ValueKey('history-next-page')));
        await tester.pumpAndSettle();
      }
      expect(readings.lastPageOffset, 40);
      expect(find.text('41–45 von 45 Projektständen'), findsOneWidget);
      expect(
        tester
            .widget<OutlinedButton>(
              find.byKey(const ValueKey('history-next-page')),
            )
            .onPressed,
        isNull,
      );
      await tester.tap(find.byKey(const ValueKey('history-previous-page')));
      await tester.pumpAndSettle();
      expect(readings.lastPageOffset, 30);
      await tester.enterText(search, 'SPEZIALFUND');
      await tester.pump(const Duration(milliseconds: 251));
      await tester.pumpAndSettle();
      expect(readings.lastPageOffset, 0);
      expect(find.text('1 Treffer'), findsOneWidget);
    },
  );

  testWidgets('history shows the explicit page progress equation', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(430, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final meter = Meter(
      id: 'meter_page_progress',
      label: 'Der Alchimist',
      type: MeterType.knitting,
      unit: 'Reihen',
      createdAt: DateTime.utc(2026, 9, 1),
      updatedAt: DateTime.utc(2026, 9, 2),
    );
    final meters = MemoryMeterRepository()..items[meter.id] = meter;
    final readings = MemoryReadingRepository();

    MeterReading reading(String id, String value, DateTime capturedAt) {
      return MeterReading(
        id: id,
        meterId: meter.id,
        meter: MeterSnapshot.fromMeter(meter),
        value: ReadingValue.tryParse(value)!,
        capturedAt: capturedAt,
        timezoneOffsetMinutes: 120,
        storedAt: capturedAt,
        updatedAt: capturedAt,
        source: ReadingSource.camera,
        photoPath: '/tmp/$id.jpg',
        photoSha256: 'a' * 64,
        ocrRawText: value,
        ocrCandidate: value,
        manifestSha256: 'b' * 64,
      );
    }

    readings.items['page_85'] = reading(
      'page_85',
      '85',
      DateTime.utc(2026, 9, 1, 10),
    );
    readings.items['page_130'] = reading(
      'page_130',
      '130',
      DateTime.utc(2026, 9, 2, 10),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          meterRepositoryProvider.overrideWithValue(meters),
          meterReadingRepositoryProvider.overrideWithValue(readings),
          evidenceExportRepositoryProvider.overrideWithValue(
            MemoryEvidenceExportRepository(),
          ),
          meterReminderRepositoryProvider.overrideWithValue(
            NoopMeterReminderRepository(),
          ),
        ],
        child: const MeterReadingLogApp(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Der Alchimist'));
    await tester.pumpAndSettle();

    expect(find.text('Reihe 85 → 130 = 45 Reihen Fortschritt'), findsOneWidget);
  });

  testWidgets('saved history PDFs keep both creation variants available', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(430, 3000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final temp = Directory.systemTemp.createTempSync(
      'current_history_screen_test_',
    );
    addTearDown(() => temp.deleteSync(recursive: true));
    final compactPdf = File('${temp.path}/compact.pdf');
    final photoPdf = File('${temp.path}/photos.pdf');
    compactPdf.writeAsBytesSync(const [0x25, 0x50, 0x44, 0x46]);
    photoPdf.writeAsBytesSync(const [0x25, 0x50, 0x44, 0x46]);
    final meter = Meter(
      id: 'meter_current_history',
      label: 'Gas Keller',
      type: MeterType.crochet,
      unit: 'Runden',
      createdAt: DateTime.utc(2026, 9, 1),
      updatedAt: DateTime.utc(2026, 9, 1),
    );
    final meters = MemoryMeterRepository()..items[meter.id] = meter;
    final readings = MemoryReadingRepository();
    final reading = MeterReading(
      id: 'reading_current_history',
      meterId: meter.id,
      meter: MeterSnapshot.fromMeter(meter),
      value: ReadingValue.tryParse('84,2')!,
      capturedAt: DateTime.utc(2026, 9, 2, 10),
      timezoneOffsetMinutes: 120,
      storedAt: DateTime.utc(2026, 9, 2, 10),
      updatedAt: DateTime.utc(2026, 9, 2, 10),
      source: ReadingSource.camera,
      photoPath: '/tmp/current-history-photo.jpg',
      photoSha256: 'a' * 64,
      ocrRawText: '84,2',
      ocrCandidate: '84,2',
      manifestSha256: 'b' * 64,
    );
    readings.items[reading.id] = reading;
    final exports = MemoryEvidenceExportRepository();
    exports.items['history_compact'] = EvidenceExportRecord(
      id: 'history_compact',
      meterId: meter.id,
      kind: EvidenceExportKind.meterHistory,
      readingIds: [reading.id],
      createdAt: DateTime.utc(2026, 9, 5, 10),
      fileName: 'compact.pdf',
      filePath: compactPdf.path,
      pdfSha256: 'c' * 64,
      manifestSha256: 'compact-history-manifest',
      photoMode: EvidencePhotoMode.withoutPhotos,
    );
    exports.items['history_photos'] = EvidenceExportRecord(
      id: 'history_photos',
      meterId: meter.id,
      kind: EvidenceExportKind.meterHistory,
      readingIds: [reading.id],
      createdAt: DateTime.utc(2026, 9, 5, 10, 1),
      fileName: 'photos.pdf',
      filePath: photoPdf.path,
      pdfSha256: 'd' * 64,
      manifestSha256: 'photo-history-manifest',
      photoMode: EvidencePhotoMode.currentPhotos,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          meterRepositoryProvider.overrideWithValue(meters),
          meterReadingRepositoryProvider.overrideWithValue(readings),
          evidenceExportRepositoryProvider.overrideWithValue(exports),
          evidenceFileAvailableProvider.overrideWith(
            (ref, path) async => File(path).existsSync(),
          ),
          evidenceReportServiceProvider.overrideWithValue(
            _SynchronousDeleteEvidenceReportService(exports),
          ),
        ],
        child: const MeterReadingLogApp(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Gas Keller'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Projektprotokoll für den Projektverlauf erstellen'),
      250,
      scrollable: find.byType(Scrollable).last,
    );

    final compactCard = find.byKey(
      const ValueKey('evidence-export-history_compact'),
    );
    final photoCard = find.byKey(
      const ValueKey('evidence-export-history_photos'),
    );
    expect(find.text('Gespeicherte Projektprotokolle'), findsOneWidget);
    expect(find.text('2 Projektprotokolle'), findsOneWidget);
    expect(compactCard, findsNothing);
    expect(photoCard, findsNothing);
    await tester.tap(
      find.byKey(const ValueKey('saved-history-pdfs-expansion')),
    );
    await tester.pumpAndSettle();
    expect(compactCard, findsOneWidget);
    expect(photoCard, findsOneWidget);
    expect(
      find.descendant(
        of: compactCard,
        matching: find.text('Aktueller Projektverlaufsprotokoll'),
      ),
      findsNothing,
    );
    expect(
      find.descendant(
        of: photoCard,
        matching: find.text('Aktueller Projektverlaufsprotokoll'),
      ),
      findsNothing,
    );
    expect(
      find.text('Beide aktuellen Varianten bereits erstellt'),
      findsNothing,
    );
    final createButton = tester.widget<FilledButton>(
      find.widgetWithText(
        FilledButton,
        'Projektprotokoll für den Projektverlauf erstellen',
      ),
    );
    expect(createButton.onPressed, isNotNull);

    await tester.tap(
      find.text('Projektprotokoll für den Projektverlauf erstellen'),
    );
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<ListTile>(
            find.byKey(const ValueKey('evidence-photo-mode-withoutPhotos')),
          )
          .enabled,
      isTrue,
    );
    expect(
      tester
          .widget<ListTile>(
            find.byKey(const ValueKey('evidence-photo-mode-currentPhotos')),
          )
          .enabled,
      isTrue,
    );
    await tester.tapAt(const Offset(8, 8));
    await tester.pumpAndSettle();
  });

  testWidgets('saved history PDFs remain accessible without readings', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(430, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final temp = Directory.systemTemp.createTempSync(
      'history_without_readings_test_',
    );
    addTearDown(() => temp.deleteSync(recursive: true));
    final historyPdf = File('${temp.path}/history.pdf');
    historyPdf.writeAsBytesSync(const [0x25, 0x50, 0x44, 0x46]);
    final meter = Meter(
      id: 'meter_history_without_readings',
      label: 'Alter GasProjekt',
      type: MeterType.crochet,
      unit: 'Runden',
      createdAt: DateTime.utc(2026, 9, 1),
      updatedAt: DateTime.utc(2026, 9, 1),
    );
    final meters = MemoryMeterRepository()..items[meter.id] = meter;
    final exports = MemoryEvidenceExportRepository();
    exports.items['orphaned_history_export'] = EvidenceExportRecord(
      id: 'orphaned_history_export',
      meterId: meter.id,
      kind: EvidenceExportKind.meterHistory,
      readingIds: const ['removed_reading'],
      createdAt: DateTime.utc(2026, 9, 5, 8, 30),
      fileName: 'alter_verlauf.pdf',
      filePath: historyPdf.path,
      pdfSha256: 'c' * 64,
      manifestSha256: 'd' * 64,
      photoMode: EvidencePhotoMode.withoutPhotos,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          meterRepositoryProvider.overrideWithValue(meters),
          meterReadingRepositoryProvider.overrideWithValue(
            MemoryReadingRepository(),
          ),
          evidenceExportRepositoryProvider.overrideWithValue(exports),
          evidenceFileAvailableProvider.overrideWith(
            (ref, path) async => File(path).existsSync(),
          ),
        ],
        child: const MeterReadingLogApp(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Alter GasProjekt'));
    await tester.pumpAndSettle();

    expect(
      find.text('Projektprotokoll für den Projektverlauf erstellen'),
      findsNothing,
    );
    expect(find.text('Gespeicherte Projektprotokolle'), findsOneWidget);
    expect(find.text('1 Projektprotokoll'), findsOneWidget);
    expect(
      find.byKey(const ValueKey('evidence-export-orphaned_history_export')),
      findsNothing,
    );
    await tester.tap(
      find.byKey(const ValueKey('saved-history-pdfs-expansion')),
    );
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('evidence-export-orphaned_history_export')),
      findsOneWidget,
    );
    expect(find.textContaining('Noch kein Projektstand.'), findsOneWidget);
  });

  testWidgets('history PDFs precede readings and show progress', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(430, 3000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final temp = Directory.systemTemp.createTempSync('history_screen_test_');
    addTearDown(() => temp.deleteSync(recursive: true));
    final historyPdf = File('${temp.path}/history.pdf');
    historyPdf.writeAsBytesSync(const [0x25, 0x50, 0x44, 0x46]);
    final meter = Meter(
      id: 'meter_pdf',
      label: 'Wasser Bad',
      type: MeterType.knitting,
      unit: 'Runden',
      createdAt: DateTime.utc(2026, 9, 1),
      updatedAt: DateTime.utc(2026, 9, 1),
    );
    final meters = MemoryMeterRepository()..items[meter.id] = meter;
    final readings = _PendingRevisionRepository();
    final exports = MemoryEvidenceExportRepository();
    readings.items['reading_pdf'] = MeterReading(
      id: 'reading_pdf',
      meterId: meter.id,
      meter: MeterSnapshot.fromMeter(meter),
      value: ReadingValue.tryParse('42,1')!,
      capturedAt: DateTime.utc(2026, 9, 2, 10),
      timezoneOffsetMinutes: 120,
      storedAt: DateTime.utc(2026, 9, 2, 10),
      updatedAt: DateTime.utc(2026, 9, 2, 10),
      source: ReadingSource.camera,
      photoPath: '/tmp/photo.jpg',
      photoSha256: 'a' * 64,
      ocrRawText: '42,1',
      ocrCandidate: '42,1',
      manifestSha256: 'b' * 64,
    );
    exports.items['history_export'] = EvidenceExportRecord(
      id: 'history_export',
      meterId: meter.id,
      kind: EvidenceExportKind.meterHistory,
      readingIds: const ['reading_pdf'],
      createdAt: DateTime.utc(2026, 9, 5, 8, 30),
      fileName: 'leseverlauf_der_alchimist_20260905_083000.pdf',
      filePath: historyPdf.path,
      pdfSha256: 'c' * 64,
      manifestSha256: 'd' * 64,
      photoMode: EvidencePhotoMode.withoutPhotos,
    );
    exports.items['single_export'] = EvidenceExportRecord(
      id: 'single_export',
      meterId: meter.id,
      kind: EvidenceExportKind.singleReading,
      readingIds: const ['reading_pdf'],
      createdAt: DateTime.utc(2026, 9, 5, 8),
      fileName: 'lesestand_der_alchimist_20260905_080000.pdf',
      filePath: '/tmp/single.pdf',
      pdfSha256: 'e' * 64,
      manifestSha256: 'f' * 64,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          meterRepositoryProvider.overrideWithValue(meters),
          meterReadingRepositoryProvider.overrideWithValue(readings),
          evidenceExportRepositoryProvider.overrideWithValue(exports),
          evidenceFileAvailableProvider.overrideWith(
            (ref, path) async => File(path).existsSync(),
          ),
          evidenceReportServiceProvider.overrideWithValue(
            _SynchronousDeleteEvidenceReportService(exports),
          ),
          meterPhotoCaptureRepositoryProvider.overrideWithValue(
            _FixedPhotoRepository(),
          ),
          meterReminderRepositoryProvider.overrideWithValue(
            NoopMeterReminderRepository(),
          ),
        ],
        child: const MeterReadingLogApp(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Wasser Bad'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Projektprotokoll für den Projektverlauf erstellen'),
      250,
      scrollable: find.byType(Scrollable).last,
    );
    expect(find.text('Projektprotokoll · Projektverlauf'), findsOneWidget);
    expect(
      find.textContaining('kompakt ohne Fotos oder mit allen aktuellen Fotos'),
      findsOneWidget,
    );
    final readingCard = find.byKey(const ValueKey('reading-card-reading_pdf'));
    expect(readingCard, findsOneWidget);
    expect(
      find.descendant(of: readingCard, matching: find.text('Aktuelle Runde')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: readingCard, matching: find.text('Runde 42,1')),
      findsOneWidget,
    );
    final dateBadge = find.byKey(
      const ValueKey('reading-date-badge-reading_pdf'),
    );
    expect(dateBadge, findsOneWidget);
    expect(
      find.descendant(
        of: dateBadge,
        matching: find.byIcon(Icons.calendar_month_outlined),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: dateBadge,
        matching: find.textContaining('Erfasst ·'),
      ),
      findsOneWidget,
    );
    expect(
      tester.getTopLeft(dateBadge).dy,
      lessThan(
        tester
            .getTopLeft(
              find.descendant(
                of: readingCard,
                matching: find.text('Aktuelle Runde'),
              ),
            )
            .dy,
      ),
    );
    expect(
      find.descendant(of: readingCard, matching: find.text('Erfasst am')),
      findsNothing,
    );
    expect(
      find.byKey(const ValueKey('reading-thumbnail-reading_pdf')),
      findsOneWidget,
    );
    final savedEvidenceTitle = find.text('Gespeicherte Projektprotokolle');
    final historyActionTitle = find.text('Projektprotokoll · Projektverlauf');
    final historySectionTitle = find.text('Projektverlauf');
    final historyExportCard = find.byKey(
      const ValueKey('evidence-export-history_export'),
    );
    expect(savedEvidenceTitle, findsOneWidget);
    expect(find.text('1 Projektprotokoll'), findsOneWidget);
    expect(historyExportCard, findsNothing);
    expect(
      tester.getTopLeft(historyActionTitle.first).dy,
      lessThan(tester.getTopLeft(savedEvidenceTitle).dy),
    );
    expect(
      tester.getTopLeft(savedEvidenceTitle).dy,
      lessThan(tester.getTopLeft(historySectionTitle).dy),
    );
    expect(
      tester.getTopLeft(historySectionTitle).dy,
      lessThan(tester.getTopLeft(readingCard).dy),
    );
    await tester.tap(
      find.byKey(const ValueKey('saved-history-pdfs-expansion')),
    );
    await tester.pumpAndSettle();
    expect(historyExportCard, findsOneWidget);
    expect(
      find.byKey(const ValueKey('current-evidence-badge-history_export')),
      findsNothing,
    );
    expect(
      find.byKey(const ValueKey('evidence-export-single_export')),
      findsNothing,
    );
    expect(find.text('Projektprotokoll · Projektverlauf'), findsWidgets);
    expect(find.textContaining('1 Projektstand enthalten'), findsOneWidget);
    expect(find.text('Einzelnachweis'), findsNothing);
    expect(find.text('Aktuelle Reihe: 42,1 Runden'), findsNothing);
    expect(find.text('Lokal gespeichert'), findsOneWidget);
    expect(
      find.text('leseverlauf_der_alchimist_20260905_083000.pdf'),
      findsNothing,
    );
    expect(find.textContaining('cccccccc'), findsNothing);
    expect(
      tester.getTopLeft(historyActionTitle.first).dy,
      lessThan(tester.getTopLeft(historyExportCard).dy),
    );
    final deleteHistory = find.byKey(
      const ValueKey('delete-evidence-history_export'),
    );
    expect(deleteHistory, findsOneWidget);
    expect(
      tester.widget<IconButton>(deleteHistory).tooltip,
      'Projektprotokoll löschen',
    );
    await tester.tap(deleteHistory);
    await tester.pumpAndSettle();
    expect(find.text('Projektprotokoll löschen?'), findsOneWidget);
    expect(
      find.textContaining('außerhalb der App gespeicherte Kopien'),
      findsOneWidget,
    );
    await tester.tap(find.widgetWithText(OutlinedButton, 'Abbrechen'));
    await tester.pumpAndSettle();
    expect(exports.items, contains('history_export'));

    await tester.tap(deleteHistory);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Löschen'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(exports.items, isNot(contains('history_export')));
    expect(
      find.byKey(const ValueKey('evidence-export-history_export')),
      findsNothing,
    );
    expect(find.text('Gespeicherte Projektprotokolle'), findsNothing);
    expect(find.text('Projektprotokoll gelöscht.'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Projektprotokoll für den Projektverlauf erstellen'),
      -250,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.tap(
      find.text('Projektprotokoll für den Projektverlauf erstellen'),
    );
    await tester.pumpAndSettle();
    expect(find.text('PDF-Inhalt wählen'), findsOneWidget);
    expect(find.text('Kompakt ohne Fotos'), findsOneWidget);
    expect(find.text('Mit aktuellen Fotos'), findsOneWidget);
    await tester.tap(find.text('Kompakt ohne Fotos'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Projektprotokoll wird erstellt'), findsOneWidget);
    expect(
      find.text(
        'Projektstände und Notizen werden für die kompakte PDF zusammengestellt.',
      ),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('pdf-export-progress')), findsOneWidget);
    expect(
      find.text('Projektprotokoll für den Projektverlauf erstellen'),
      findsOneWidget,
    );
    expect(readings.loadForMeterCalls, 1);
  });
}

class _PendingRevisionRepository extends MemoryReadingRepository {
  final _pending = Completer<List<ReadingRevision>>();

  @override
  Future<List<ReadingRevision>> loadRevisions(String readingId) {
    return _pending.future;
  }
}

class _CountingHistoryReadingRepository extends MemoryReadingRepository {
  int watchForMeterCalls = 0;

  @override
  Stream<List<MeterReading>> watchForMeter(String meterId) {
    watchForMeterCalls++;
    return super.watchForMeter(meterId);
  }
}

class _SynchronousDeleteEvidenceReportService extends EvidenceReportService {
  _SynchronousDeleteEvidenceReportService(
    MemoryEvidenceExportRepository repository,
  ) : super(exports: repository);

  @override
  Future<void> delete(EvidenceExportRecord record) async {
    await exports.delete(record.id);
  }
}

class _FixedPhotoRepository implements MeterPhotoCaptureRepository {
  int captureCount = 0;

  final photo = StoredMeterPhoto(
    path: '/synthetic/meter.jpg',
    sha256: 'a' * 64,
    source: ReadingSource.camera,
    capturedAt: DateTime(2026, 9, 2, 10, 30),
  );

  @override
  Future<StoredMeterPhoto?> capture(ReadingSource source) async {
    captureCount++;
    return photo;
  }

  @override
  Future<void> delete(String path) async {}

  @override
  Future<StoredMeterPhoto?> recoverLostCapture() async => null;
}
