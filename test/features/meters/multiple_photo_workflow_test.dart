import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:strick_haekelbuch/app/app.dart';
import 'package:strick_haekelbuch/app/app_providers.dart';
import 'package:strick_haekelbuch/app/app_theme.dart';
import 'package:strick_haekelbuch/core/files/meter_photo_repository.dart';
import 'package:strick_haekelbuch/features/meters/domain/meter_reading.dart';
import 'package:strick_haekelbuch/features/meters/presentation/reading_photo_gallery.dart';

import '../../support/fakes.dart';
import '../../support/reading_fixtures.dart';

void main() {
  testWidgets(
    'capture mixed photos, browse them, replace one, remove one and add more',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(430, 1800));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final meter = sampleBook(label: 'Mein Schal');
      final readings = MemoryReadingRepository();
      final photos = _Photos();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            meterRepositoryProvider.overrideWithValue(
              MemoryMeterRepository()..items[meter.id] = meter,
            ),
            meterReadingRepositoryProvider.overrideWithValue(readings),
            evidenceExportRepositoryProvider.overrideWithValue(
              MemoryEvidenceExportRepository(),
            ),
            meterPhotoCaptureRepositoryProvider.overrideWithValue(photos),
            meterReminderRepositoryProvider.overrideWithValue(
              NoopMeterReminderRepository(),
            ),
          ],
          child: const MeterReadingLogApp(),
        ),
      );
      await tester.pumpAndSettle();
      await _tap(tester, 'Mein Schal');
      await _tap(tester, 'Projektstand erfassen');
      await _tap(tester, 'Projekt fotografieren');
      await _tap(tester, 'Weiteres Foto aufnehmen');
      await _tap(tester, 'Fotos aus Galerie hinzufügen');
      expect(find.text('Aktuelle Fotos (4)'), findsOneWidget);
      final value = find.widgetWithText(TextFormField, 'Aktuelle Reihe *');
      await tester.ensureVisible(value);
      await tester.enterText(value, '25');
      FocusManager.instance.primaryFocus?.unfocus();
      await _tap(tester, 'Projektstand bestätigen und speichern');
      await _wait(tester, () => readings.items.isNotEmpty);
      final first = readings.items.values.single;
      expect(first.currentPhotos, hasLength(4));
      expect(first.currentPhotos.map((p) => p.source), [
        ReadingSource.camera,
        ReadingSource.camera,
        ReadingSource.gallery,
        ReadingSource.gallery,
      ]);
      final image = find
          .descendant(
            of: find.byType(ReadingPhotoGallery),
            matching: find.byType(InkWell),
          )
          .first;
      await tester.ensureVisible(image);
      await tester.tap(image);
      await tester.pumpAndSettle();
      expect(find.text('Foto 1 von 4'), findsOneWidget);
      await tester.tap(find.byTooltip('Nächstes Foto'));
      await tester.pumpAndSettle();
      expect(find.text('Foto 2 von 4'), findsOneWidget);
      expect(find.byType(InteractiveViewer), findsWidgets);
      await tester.tap(find.byType(BackButton).last);
      await tester.pumpAndSettle();
      await _tap(tester, 'Korrigieren');
      await _photoAction(tester, 2, 'Foto ersetzen');
      await _tap(tester, 'Aus Galerie wählen');
      await _photoAction(tester, 3, 'Foto entfernen');
      await _tap(tester, 'Fotos aus Galerie hinzufügen');
      await _tap(tester, 'Korrektur protokollieren');
      await _wait(
        tester,
        () => readings.items.values.single.currentPhotos.length == 5,
      );
      final corrected = readings.items.values.single;
      expect(corrected.value.displayText, '25');
      expect(corrected.capturedAt, first.capturedAt);
      expect(corrected.currentPhotos.first.id, first.currentPhotos.first.id);
      expect(corrected.photoHistory.map((p) => p.id).toSet(), {
        first.currentPhotos[1].id,
        first.currentPhotos[2].id,
      });
      final revision = (await readings.loadRevisions(first.id)).single;
      expect(
        revision.photoChange!.beforeIds,
        first.currentPhotos.map((p) => p.id),
      );
      expect(
        revision.photoChange!.afterIds,
        corrected.currentPhotos.map((p) => p.id),
      );
      expect(photos.deleted, isEmpty);
      await _tap(tester, 'Korrigieren');
      await _tap(tester, 'Weiteres Foto aufnehmen');
      await tester.tap(find.byType(BackButton).last);
      await tester.pumpAndSettle();
      await _tap(tester, 'Korrektur verwerfen');
      expect(readings.items.values.single.toJson(), corrected.toJson());
      expect(photos.deleted, ['/photo8.jpg']);
      expect(tester.takeException(), isNull);
    },
  );

  for (final brightness in Brightness.values) {
    testWidgets(
      'multi photo editor fits narrow phone and large type in $brightness',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(320, 700));
        addTearDown(() => tester.binding.setSurfaceSize(null));
        final photo = sampleReading().currentPhotos.single;
        await tester.pumpWidget(
          MaterialApp(
            theme: brightness == Brightness.dark
                ? AppTheme.dark()
                : AppTheme.light(),
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: const TextScaler.linear(2)),
              child: child!,
            ),
            home: Scaffold(
              body: SingleChildScrollView(
                child: ReadingPhotoEditor(
                  photos: [photo, photo, photo],
                  busy: false,
                  correction: true,
                  onCamera: () {},
                  onGallery: () {},
                  onReplace: (_) {},
                  onRemove: (_) {},
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      },
    );
  }
}

Future<void> _tap(WidgetTester tester, String text) async {
  final finder = find.text(text).last;
  if (finder.evaluate().isEmpty) {
    await tester.scrollUntilVisible(
      finder,
      300,
      scrollable: find.byType(Scrollable).first,
    );
  }
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Future<void> _photoAction(WidgetTester tester, int index, String action) async {
  final button = find.byTooltip('Foto $index bearbeiten');
  await tester.ensureVisible(button);
  await tester.tap(button);
  await tester.pumpAndSettle();
  await _tap(tester, action);
}

Future<void> _wait(WidgetTester tester, bool Function() ready) async {
  for (var i = 0; i < 100 && !ready(); i++) {
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 10)),
    );
    await tester.pump();
  }
  await tester.pumpAndSettle();
  expect(ready(), true);
}

class _Photos extends UnsupportedMeterPhotoCaptureRepository
    implements MultiPhotoCaptureRepository {
  var count = 0;
  final deleted = <String>[];
  StoredMeterPhoto _next(ReadingSource source) => StoredMeterPhoto(
    path: '/photo${++count}.jpg',
    sha256: count.toString().padLeft(64, '0'),
    source: source,
    capturedAt: DateTime.utc(2026, 9, 17),
  );
  @override
  Future<StoredMeterPhoto?> capture(ReadingSource source) async =>
      _next(source);
  @override
  Future<PhotoImportResult> pickGalleryPhotos({
    PhotoImportProgress? onProgress,
  }) async => PhotoImportResult(
    photos: [_next(ReadingSource.gallery), _next(ReadingSource.gallery)],
  );
  @override
  Future<PhotoImportResult> recoverPhotos({
    required ReadingSource source,
    PhotoImportProgress? onProgress,
  }) async => const PhotoImportResult();
  @override
  Future<void> delete(String path) async {
    deleted.add(path);
  }
}
