import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static const actionTextStyle = TextStyle(
    fontSize: 16,
    height: 1.25,
    fontWeight: FontWeight.w600,
  );
  static const actionPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 12,
  );
  static const actionIconSize = 22.0;
  static const actionHeight = 56.0;

  static const _seed = Color(0xFF526B59);
  static const _lightSurface = Color(0xFFFAF6EF);
  static const _lightCard = Color(0xFFFFFCF7);
  static const _darkSurface = Color(0xFF20231F);
  static const _darkCard = Color(0xFF292F29);

  static ThemeData light() {
    final scheme =
        ColorScheme.fromSeed(
          seedColor: _seed,
          brightness: Brightness.light,
          surface: _lightSurface,
        ).copyWith(
          primary: _seed,
          primaryContainer: const Color(0xFFE0E8DC),
          onPrimaryContainer: const Color(0xFF293F2F),
          secondary: const Color(0xFF9B644E),
          surfaceContainerLow: _lightCard,
          surfaceContainerLowest: const Color(0xFFFFFCF7),
          outlineVariant: const Color(0xFFDEDCD0),
        );
    return _base(scheme);
  }

  static ThemeData dark() {
    final scheme =
        ColorScheme.fromSeed(
          seedColor: _seed,
          brightness: Brightness.dark,
          surface: _darkSurface,
        ).copyWith(
          primary: const Color(0xFFB8CCB4),
          primaryContainer: const Color(0xFF364A3A),
          onPrimaryContainer: const Color(0xFFDDEAD6),
          secondary: const Color(0xFFE0B29B),
          surfaceContainerLow: _darkCard,
          surfaceContainerLowest: const Color(0xFF191D19),
          outlineVariant: const Color(0xFF495248),
        );
    return _base(scheme);
  }

  static ThemeData _base(ColorScheme scheme) {
    const buttonStyle = ButtonStyle(
      minimumSize: WidgetStatePropertyAll(Size(0, actionHeight)),
      padding: WidgetStatePropertyAll(actionPadding),
      textStyle: WidgetStatePropertyAll(actionTextStyle),
      iconSize: WidgetStatePropertyAll(actionIconSize),
      shape: WidgetStatePropertyAll(StadiumBorder()),
      visualDensity: VisualDensity.standard,
      tapTargetSize: MaterialTapTargetSize.padded,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: scheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: scheme.outlineVariant),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerLowest,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
      filledButtonTheme: const FilledButtonThemeData(style: buttonStyle),
      outlinedButtonTheme: const OutlinedButtonThemeData(style: buttonStyle),
      elevatedButtonTheme: const ElevatedButtonThemeData(style: buttonStyle),
      textButtonTheme: const TextButtonThemeData(style: buttonStyle),
      iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
          minimumSize: WidgetStatePropertyAll(Size(48, 48)),
          visualDensity: VisualDensity.standard,
          tapTargetSize: MaterialTapTargetSize.padded,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        extendedSizeConstraints: BoxConstraints(minHeight: actionHeight),
        extendedTextStyle: actionTextStyle,
        extendedPadding: actionPadding,
        extendedIconLabelSpacing: 8,
        iconSize: actionIconSize,
      ),
    );
  }
}
