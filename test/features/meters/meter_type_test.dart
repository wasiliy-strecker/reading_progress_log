import 'package:flutter_test/flutter_test.dart';
import 'package:strick_haekelbuch/features/meters/domain/meter.dart';

void main() {
  test('both techniques support rows and rounds independently', () {
    expect(MeterType.values.map((type) => type.label), ['Stricken', 'Häkeln']);
    expect(MeterType.values.map((type) => type.wireName), [
      'knitting',
      'crochet',
    ]);
    for (final type in MeterType.values) {
      expect(type.availableUnits, ['Reihen', 'Runden']);
      expect(type.defaultUnit, 'Reihen');
      for (final unit in type.availableUnits) {
        final project = Meter(
          id: 'project',
          label: 'Salbei-Pullover',
          type: type,
          unit: unit,
          meterNumber: 'Merinowolle',
          location: '4,5 mm',
          createdAt: DateTime.utc(2026),
          updatedAt: DateTime.utc(2026),
        );
        final restored = Meter.fromJson(project.toJson());
        expect(restored.type, type);
        expect(restored.unit, unit);
        expect(restored.meterNumber, 'Merinowolle');
        expect(restored.location, '4,5 mm');
        final snapshot = MeterSnapshot.fromJson(
          MeterSnapshot.fromMeter(project).toJson(),
        );
        expect(snapshot.unit, unit);
        expect(snapshot.location, '4,5 mm');
      }
    }
  });
  test('progress wording uses the selected unit', () {
    expect(currentProgressLabel('Reihen'), 'Aktuelle Reihe');
    expect(currentProgressLabel('Runden'), 'Aktuelle Runde');
    expect(progressValueLabel('85', 'Runden'), 'Runde 85');
  });
}
