import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:strick_haekelbuch/app/app_theme.dart';
import 'package:strick_haekelbuch/features/meters/domain/meter.dart';
import 'package:strick_haekelbuch/features/meters/domain/meter_reading.dart';
import 'package:strick_haekelbuch/features/meters/domain/reading_value.dart';
import 'package:strick_haekelbuch/features/meters/presentation/reading_history_tile.dart';

void main() {
  for (final dark in [false, true]) {
    for (final scale in [1.0, 2.0]) {
      for (final unit in ['Reihen', 'Runden']) {
        testWidgets(
          'progress fits a narrow tile: dark=$dark scale=$scale $unit',
          (tester) async {
            await tester.binding.setSurfaceSize(const Size(320, 700));
            addTearDown(() => tester.binding.setSurfaceSize(null));
            await tester.pumpWidget(
              MaterialApp(
                theme: dark ? AppTheme.dark() : AppTheme.light(),
                builder: (context, child) => MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(textScaler: TextScaler.linear(scale)),
                  child: child!,
                ),
                home: Scaffold(
                  body: SingleChildScrollView(
                    child: ReadingHistoryTile(
                      reading: _reading('130', unit),
                      previous: _reading('85', unit),
                      showDelta: true,
                      onTap: () {},
                    ),
                  ),
                ),
              ),
            );
            await tester.pumpAndSettle();
            expect(
              find.text(
                unit == 'Reihen'
                    ? 'Reihe 85 → 130 = 45 Reihen Fortschritt'
                    : 'Runde 85 → 130 = 45 Runden Fortschritt',
              ),
              findsOneWidget,
            );
            expect(tester.takeException(), isNull);
          },
        );
      }
    }
  }
}

MeterReading _reading(String value, String unit) => MeterReading(
  id: value,
  meterId: 'book',
  meter: MeterSnapshot.fromMeter(
    Meter(
      id: 'book',
      label: 'Synthetisches Projekt',
      type: MeterType.knitting,
      unit: unit,
      createdAt: DateTime.utc(2026),
      updatedAt: DateTime.utc(2026),
    ),
  ),
  value: ReadingValue.tryParse(value)!,
  capturedAt: DateTime.utc(2026, 9, 13),
  storedAt: DateTime.utc(2026, 9, 13),
  updatedAt: DateTime.utc(2026, 9, 13),
  timezoneOffsetMinutes: 120,
  source: ReadingSource.gallery,
  photoPath: '/missing-synthetic-photo.jpg',
  photoSha256: 'a' * 64,
  ocrRawText: value,
  ocrCandidate: value,
  manifestSha256: 'b' * 64,
);
