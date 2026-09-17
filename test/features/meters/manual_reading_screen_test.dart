import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:strick_haekelbuch/app/app_providers.dart';
import 'package:strick_haekelbuch/core/files/evidence_photo_asset_repository.dart';
import 'package:strick_haekelbuch/core/files/meter_photo_repository.dart';
import 'package:strick_haekelbuch/features/meters/domain/meter_reading.dart';
import 'package:strick_haekelbuch/features/meters/presentation/capture_reading_screen.dart';
import 'package:strick_haekelbuch/features/meters/presentation/edit_reading_screen.dart';
import 'package:strick_haekelbuch/features/meters/presentation/reading_detail_screen.dart';
import 'package:strick_haekelbuch/features/meters/presentation/reading_history_tile.dart';

import '../../support/fakes.dart';
import '../../support/reading_fixtures.dart';

void main() {
  testWidgets(
    'examples close back to capture choices without creating a draft',
    (tester) async {
      final readings = MemoryReadingRepository();
      final photos = _Photos();
      await _open(tester, readings, photos, pushCapture: true);
      await _press(tester, 'Beispiele ansehen');
      expect(find.text('Beispielfotos'), findsOneWidget);
      await tester.tap(find.byTooltip('Schließen'));
      await tester.pumpAndSettle();
      _expectCaptureOptions();
      expect(photos.captures, 0);
      expect(readings.items, isEmpty);
      await _back(tester, systemBack: true);
      expect(find.text('Projektstand verwerfen?'), findsNothing);
      expect(find.text('Projektübersicht'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('round entry and correction retain the round label', (
    tester,
  ) async {
    final readings = MemoryReadingRepository();
    await _open(tester, readings, _Photos(), unit: 'Runden');
    await _press(tester, 'Stand eintragen');
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Aktuelle Runde *'),
      '32',
    );
    await _press(tester, 'Projektstand speichern');
    await _settleSave(tester, () => readings.items.isNotEmpty);
    expect(readings.items.values.single.meter.unit, 'Runden');
    await _press(tester, 'Korrigieren');
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Aktuelle Runde *'),
      '31',
    );
    await _press(tester, 'Korrektur protokollieren');
    await _settleSave(
      tester,
      () => readings.items.values.single.value.displayText == '31',
    );
    final saved = readings.items.values.single;
    expect(
      (await readings.loadRevisions(saved.id)).single.changes,
      contains('Aktuelle Runde'),
    );
    expect(tester.takeException(), isNull);
  });

  for (final manual in [false, true]) {
    testWidgets('future reading saves and corrects directly, manual=$manual', (
      tester,
    ) async {
      final readings = MemoryReadingRepository();
      await _open(tester, readings, _Photos());
      await _press(
        tester,
        manual ? 'Stand eintragen' : 'Projekt fotografieren',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Aktuelle Reihe *'),
        '150',
      );
      final selected = DateTime(2100, 1, 1, 12, 30);
      await _chooseTime(tester, selected);
      expect(find.textContaining('Zukunft'), findsNothing);
      await _press(
        tester,
        manual
            ? 'Projektstand speichern'
            : 'Projektstand bestätigen und speichern',
      );
      expect(find.text('Zukünftigen Zeitpunkt speichern?'), findsNothing);
      await _settleSave(tester, () => readings.items.isNotEmpty);
      expect(find.text('Projektstand gespeichert.'), findsOneWidget);
      final created = readings.items.values.single;
      expect(created.capturedAt, selected.toUtc());
      expect(created.storedAt.isBefore(created.capturedAt), isTrue);
      expect(
        created.source,
        manual ? ReadingSource.manual : ReadingSource.camera,
      );
      expect(find.textContaining('Zukunft'), findsNothing);

      await _press(tester, 'Korrigieren');
      await _press(tester, 'Korrektur protokollieren');
      await _settleSave(
        tester,
        () => find.text('Keine Änderungen vorhanden.').evaluate().isNotEmpty,
      );
      expect(readings.revisions, isEmpty);
      expect(find.text('Keine Änderungen vorhanden.'), findsOneWidget);
      expect(find.text('Korrektur protokolliert.'), findsNothing);

      await _press(tester, 'Korrigieren');
      final corrected = DateTime(2100, 1, 2, 13, 45);
      await _chooseTime(tester, corrected);
      expect(find.textContaining('Zukunft'), findsNothing);
      await _press(tester, 'Korrektur protokollieren');
      expect(find.text('Zukünftigen Zeitpunkt speichern?'), findsNothing);
      await _settleSave(
        tester,
        () => readings.items.values.single.capturedAt == corrected.toUtc(),
      );
      expect(find.text('Korrektur protokolliert.'), findsOneWidget);
      final saved = readings.items.values.single;
      expect(saved.capturedAt, corrected.toUtc());
      expect(saved.storedAt, created.storedAt);
      expect(
        (await readings.loadRevisions(saved.id)).single.changes,
        contains('Zeitpunkt des Projektstands'),
      );
      expect(find.textContaining('Zukunft'), findsNothing);
    });
  }

  testWidgets(
    'primary action saves a plain reading, edits it and accepts a first photo',
    (tester) async {
      final readings = MemoryReadingRepository();
      final photos = _Photos();
      await _open(tester, readings, photos);
      final manual = find.widgetWithText(FilledButton, 'Stand eintragen');
      await tester.ensureVisible(manual);
      expect(
        tester.getTopLeft(manual).dy,
        lessThan(
          tester
              .getTopLeft(
                find.widgetWithText(OutlinedButton, 'Fotos aus Galerie'),
              )
              .dy,
        ),
      );
      await tester.tap(manual);
      await tester.pumpAndSettle();
      expect(find.text('Für eine gute Erkennung'), findsNothing);
      expect(find.byType(Image), findsNothing);
      expect(find.text('Kein sicherer Wert erkannt'), findsNothing);
      expect(find.text('Reihen'), findsWidgets);
      expect(find.text('Datum & Uhrzeit ändern'), findsOneWidget);
      final value = find.widgetWithText(TextFormField, 'Aktuelle Reihe *');
      await tester.enterText(value, '12-13');
      await _press(tester, 'Projektstand speichern');
      expect(find.text('Bitte eine ganze Zahl ab 0 eingeben.'), findsOneWidget);
      expect(readings.items, isEmpty);
      await tester.enterText(value, '130');
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Notiz'),
        'Kapitel abgeschlossen',
      );
      await _press(tester, 'Projektstand speichern');
      await _settleSave(tester, () => readings.items.isNotEmpty);
      var saved = readings.items.values.single;
      expect(saved.source, ReadingSource.manual);
      expect(saved.value.displayText, '130');
      expect(saved.note, 'Kapitel abgeschlossen');
      expect(find.text('Manuell erfasst'), findsOneWidget);
      expect(find.byType(Image), findsNothing);
      expect(photos.captures, 0);
      expect(photos.deleted, isEmpty);

      await _press(tester, 'Korrigieren');
      expect(find.byType(Image), findsNothing);
      expect(find.text('Foto aufnehmen'), findsOneWidget);
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Aktuelle Reihe *'),
        '135',
      );
      await _press(tester, 'Korrektur protokollieren');
      await _settleSave(
        tester,
        () => readings.items.values.single.value.displayText == '135',
      );
      saved = readings.items.values.single;
      expect(saved.hasPhoto, isFalse);
      expect((await readings.loadRevisions(saved.id)).single.reason, '');

      await _press(tester, 'Korrigieren');
      await _press(tester, 'Fotos aus Galerie hinzufügen');
      expect(
        find.text('Das bisherige Foto bleibt als frühere Version erhalten.'),
        findsNothing,
      );
      await _press(tester, 'Korrektur protokollieren');
      await _settleSave(tester, () => readings.items.values.single.hasPhoto);
      saved = readings.items.values.single;
      expect(saved.source, ReadingSource.gallery);
      expect(saved.photoHistory, isEmpty);
      expect(photos.captures, 1);
      expect(photos.deleted, isEmpty);
      expect(tester.takeException(), isNull);
    },
  );

  for (final systemBack in [false, true]) {
    testWidgets(
      'manual back returns to options and protects edits, systemBack=$systemBack',
      (tester) async {
        final readings = MemoryReadingRepository();
        final photos = _Photos();
        await _open(tester, readings, photos, pushCapture: true);
        await _press(tester, 'Stand eintragen');
        await _back(tester, systemBack: systemBack);
        _expectCaptureOptions();
        expect(find.text('Projektstand verwerfen?'), findsNothing);

        await _press(tester, 'Stand eintragen');
        await tester.enterText(
          find.widgetWithText(TextFormField, 'Aktuelle Reihe *'),
          '85',
        );
        await tester.enterText(
          find.widgetWithText(TextFormField, 'Notiz'),
          'Am Ärmel weiterarbeiten',
        );
        await _chooseTime(tester, DateTime(2026, 9, 1, 10));
        await _back(tester, systemBack: systemBack);
        expect(find.text('Projektstand verwerfen?'), findsOneWidget);
        await _press(tester, 'Weiter bearbeiten');
        expect(find.text('85'), findsOneWidget);
        expect(find.text('Am Ärmel weiterarbeiten'), findsOneWidget);

        await _back(tester, systemBack: systemBack);
        await _press(tester, 'Projektstand verwerfen');
        _expectCaptureOptions();
        await _press(tester, 'Stand eintragen');
        for (final field in tester.widgetList<TextFormField>(
          find.byType(TextFormField),
        )) {
          expect(field.controller!.text, isEmpty);
        }
        // A discarded date must not make the new empty form dirty.
        await _back(tester, systemBack: systemBack);
        _expectCaptureOptions();
        expect(find.text('Projektstand verwerfen?'), findsNothing);
        await _back(tester, systemBack: systemBack);
        expect(find.text('Projektübersicht'), findsOneWidget);
        expect(readings.items, isEmpty);
        expect(photos.captures, 0);
        expect(tester.takeException(), isNull);
      },
    );

    for (final source in ['Projekt fotografieren', 'Fotos aus Galerie']) {
      testWidgets(
        '$source back discards only the draft photo, systemBack=$systemBack',
        (tester) async {
          final readings = MemoryReadingRepository();
          final photos = _Photos();
          await _open(tester, readings, photos, pushCapture: true);
          await _press(tester, source);
          await _back(tester, systemBack: systemBack);
          expect(find.text('Projektstand verwerfen?'), findsOneWidget);
          await _press(tester, 'Weiter bearbeiten');
          expect(find.byType(Image), findsOneWidget);
          expect(photos.deleted, isEmpty);
          await _back(tester, systemBack: systemBack);
          await _press(tester, 'Projektstand verwerfen');
          _expectCaptureOptions();
          expect(photos.deleted, ['/synthetic-added.jpg']);
          expect(readings.items, isEmpty);
          await _press(tester, 'Stand eintragen');
          expect(find.byType(Image), findsNothing);
          await _back(tester, systemBack: systemBack);
          await _back(tester, systemBack: systemBack);
          expect(find.text('Projektübersicht'), findsOneWidget);
          expect(photos.deleted, ['/synthetic-added.jpg']);
          expect(tester.takeException(), isNull);
        },
      );
    }
  }

  testWidgets(
    'manual history entries show progress and an entry icon instead of a missing photo',
    (tester) async {
      final manual = sampleReading(source: ReadingSource.manual, value: '130');
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReadingHistoryTile(
              reading: manual,
              previous: sampleReading(value: '85'),
              showDelta: true,
              onTap: () {},
            ),
          ),
        ),
      );
      expect(
        find.text('Reihe 85 → 130 = 45 Reihen Fortschritt'),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.edit_note_outlined), findsOneWidget);
      expect(find.byIcon(Icons.broken_image_outlined), findsNothing);
      expect(find.byType(Image), findsNothing);
    },
  );
}

Future<GoRouter> _open(
  WidgetTester tester,
  MemoryReadingRepository readings,
  _Photos photos, {
  String unit = 'Reihen',
  bool pushCapture = false,
}) async {
  await tester.binding.setSurfaceSize(const Size(430, 1500));
  addTearDown(() => tester.binding.setSurfaceSize(null));
  final book = sampleBook().copyWith(unit: unit);
  final router = GoRouter(
    initialLocation: pushCapture ? '/book/${book.id}' : '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (_, _) => CaptureReadingScreen(meterId: book.id),
      ),
      GoRoute(
        path: '/reading/:id',
        name: 'readingDetail',
        builder: (_, state) =>
            ReadingDetailScreen(readingId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/edit/:id',
        name: 'readingEdit',
        builder: (_, state) =>
            EditReadingScreen(readingId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/book/:id',
        name: 'meterDetail',
        builder: (_, _) => const Scaffold(body: Text('Projektübersicht')),
      ),
    ],
  );
  addTearDown(router.dispose);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        meterRepositoryProvider.overrideWithValue(
          MemoryMeterRepository()..items[book.id] = book,
        ),
        meterReadingRepositoryProvider.overrideWithValue(readings),
        evidenceExportRepositoryProvider.overrideWithValue(
          MemoryEvidenceExportRepository(),
        ),
        evidencePhotoAssetRepositoryProvider.overrideWithValue(
          const NoopEvidencePhotoAssetRepository(),
        ),
        meterReminderRepositoryProvider.overrideWithValue(
          NoopMeterReminderRepository(),
        ),
        meterPhotoCaptureRepositoryProvider.overrideWithValue(photos),
      ],
      child: MaterialApp.router(routerConfig: router),
    ),
  );
  await tester.pumpAndSettle();
  if (pushCapture) {
    router.push<void>('/');
    await tester.pumpAndSettle();
  }
  return router;
}

Future<void> _press(WidgetTester tester, String text) async {
  FocusManager.instance.primaryFocus?.unfocus();
  await tester.pumpAndSettle();
  final target = find.text(text);
  await tester.ensureVisible(target);
  await tester.pumpAndSettle();
  await tester.tap(target);
  await tester.pump();
  // Saving also includes asynchronous hashing; settle those separately.
  if (text != 'Projektstand speichern' && text != 'Korrektur protokollieren') {
    await tester.pumpAndSettle();
  }
}

Future<void> _settleSave(WidgetTester tester, bool Function() saved) async {
  for (var attempt = 0; attempt < 50 && !saved(); attempt++) {
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 10)),
    );
    await tester.pump();
  }
  await tester.pumpAndSettle();
}

class _Photos extends UnsupportedMeterPhotoCaptureRepository {
  var captures = 0;
  final deleted = <String>[];
  @override
  Future<StoredMeterPhoto?> capture(ReadingSource source) async {
    captures++;
    return StoredMeterPhoto(
      path: '/synthetic-added.jpg',
      sha256: 'b' * 64,
      source: source,
      capturedAt: DateTime.utc(2026, 9, 15),
    );
  }

  @override
  Future<void> delete(String path) async => deleted.add(path);
}

Future<void> _chooseTime(WidgetTester tester, DateTime selected) async {
  await _press(tester, 'Datum & Uhrzeit ändern');
  // Supply the picker results; exercise the real form/save flow with that date.
  Navigator.of(tester.element(find.byType(DatePickerDialog))).pop(selected);
  await tester.pumpAndSettle();
  Navigator.of(
    tester.element(find.byType(TimePickerDialog)),
  ).pop(TimeOfDay.fromDateTime(selected));
  await tester.pumpAndSettle();
}

Future<void> _back(WidgetTester tester, {required bool systemBack}) async {
  FocusManager.instance.primaryFocus?.unfocus();
  await tester.pumpAndSettle();
  if (systemBack) {
    expect(await tester.binding.handlePopRoute(), isTrue);
  } else {
    await tester.tap(find.byType(BackButton));
  }
  await tester.pumpAndSettle();
}

void _expectCaptureOptions() {
  expect(find.text('Stand eintragen'), findsOneWidget);
  expect(find.text('Projekt fotografieren'), findsOneWidget);
  expect(find.text('Fotos aus Galerie'), findsOneWidget);
  expect(find.byType(TextFormField), findsNothing);
  expect(find.text('Projektübersicht'), findsNothing);
}
