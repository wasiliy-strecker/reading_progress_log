import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:strick_haekelbuch/app/app_theme.dart';
import 'package:strick_haekelbuch/features/meters/domain/meter.dart';
import 'package:strick_haekelbuch/features/meters/presentation/meter_visuals.dart';

void main() {
  test('project accents remain readable on cards in both themes', () {
    for (final theme in [AppTheme.light(), AppTheme.dark()]) {
      final surface = theme.colorScheme.surfaceContainerLow.computeLuminance();
      for (final technique in MeterType.values) {
        final ink = meterColor(
          technique,
          brightness: theme.brightness,
        ).computeLuminance();
        final contrast = ink > surface
            ? (ink + .05) / (surface + .05)
            : (surface + .05) / (ink + .05);
        expect(contrast, greaterThanOrEqualTo(4.5));
      }
    }
  });

  test('uses the same pill shape for all standard action buttons', () {
    final theme = AppTheme.light();

    expect(_shape(theme.filledButtonTheme.style), isA<StadiumBorder>());
    expect(_shape(theme.outlinedButtonTheme.style), isA<StadiumBorder>());
    expect(_shape(theme.elevatedButtonTheme.style), isA<StadiumBorder>());
    expect(_shape(theme.textButtonTheme.style), isA<StadiumBorder>());
  });

  test('uses the warm cream, sage and wool palette', () {
    final colors = AppTheme.light().colorScheme;

    expect(colors.surface, const Color(0xFFFAF6EF));
    expect(colors.surfaceContainerLow, const Color(0xFFFFFCF7));
    expect(colors.primary, const Color(0xFF526B59));
    expect(colors.secondary, const Color(0xFF9B644E));
  });
}

OutlinedBorder? _shape(ButtonStyle? style) {
  return style?.shape?.resolve(const <WidgetState>{});
}
