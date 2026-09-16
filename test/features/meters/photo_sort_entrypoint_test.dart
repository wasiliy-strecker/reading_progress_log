import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:strick_haekelbuch/app/app.dart';
import 'package:strick_haekelbuch/app/app_providers.dart';

import '../../support/fakes.dart';
import '../../support/reading_fixtures.dart';
import 'multiple_photos_test.dart' show testPhoto;

void main() {
  for (final count in [1, 3]) {
    testWidgets(
      'detail exposes photo sorting for multiple photos, count=$count',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(430, 1600));
        addTearDown(() => tester.binding.setSurfaceSize(null));
        final meter = sampleBook();
        final reading = sampleReading().copyWith(
          photos: List.generate(count, (i) => testPhoto('$i')),
        );
        final readings = MemoryReadingRepository()..items[reading.id] = reading;
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              initialPhotoDraftRouteProvider.overrideWithValue(
                '/reading/${reading.id}',
              ),
              meterRepositoryProvider.overrideWithValue(
                MemoryMeterRepository()..items[meter.id] = meter,
              ),
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
        if (count == 1) {
          expect(find.text('Fotos sortieren'), findsNothing);
          return;
        }
        await tester.tap(find.text('Fotos sortieren'));
        await tester.pumpAndSettle();
        expect(find.text('Projektstand korrigieren'), findsOneWidget);
        expect(
          find.text(
            'Zum Sortieren ein Foto länger gedrückt halten und verschieben.',
          ),
          findsOneWidget,
        );
        expect(readings.items[reading.id]!.toJson(), reading.toJson());
        await tester.tap(find.byTooltip('Foto 1 bearbeiten'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Nach hinten'));
        await tester.pumpAndSettle();
        final save = find.text('Korrektur protokollieren');
        await tester.ensureVisible(save);
        await tester.tap(save);
        for (
          var i = 0;
          i < 100 && readings.items[reading.id]!.currentPhotos.first.id == '0';
          i++
        ) {
          await tester.runAsync(
            () => Future<void>.delayed(const Duration(milliseconds: 10)),
          );
          await tester.pump();
        }
        await tester.pumpAndSettle();
        final sorted = readings.items[reading.id]!;
        expect(sorted.currentPhotos.map((p) => p.id), ['1', '0', '2']);
        expect(sorted.value, reading.value);
        expect(sorted.capturedAt, reading.capturedAt);
        expect(sorted.photoHistory, isEmpty);
        expect(
          (await readings.loadRevisions(
            reading.id,
          )).single.photoChange!.afterIds,
          ['1', '0', '2'],
        );
        expect(find.text('Fotos sortieren'), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );
  }
}
