import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../l10n/generated/app_localizations.dart';

export '../../l10n/generated/app_localizations.dart';

const appSupportedLocales = [
  Locale('en'),
  Locale('de'),
  Locale('es'),
  Locale('fr'),
  Locale('it'),
  Locale('pt', 'BR'),
];

const appLanguageNames = <String, String>{
  'de': 'Deutsch',
  'en': 'English',
  'es': 'Español',
  'fr': 'Français',
  'it': 'Italiano',
  'pt-BR': 'Português (Brasil)',
};

Locale resolveAppLocale(List<Locale> preferred) {
  for (final locale in preferred) {
    for (final supported in appSupportedLocales) {
      if (supported == locale) return supported;
    }
    for (final supported in appSupportedLocales) {
      if (supported.languageCode == locale.languageCode) return supported;
    }
  }
  return const Locale('en');
}

Locale localeFromTag(String tag) {
  final parts = tag.replaceAll('_', '-').split('-');
  return Locale.fromSubtags(
    languageCode: parts.first,
    scriptCode: parts.length > 1 && parts[1].length == 4 ? parts[1] : null,
    countryCode: parts.length > 1 && parts.last.length != 4 ? parts.last : null,
  );
}

/// A snapshot separates translated text from device-region formatting.
/// It is also sent explicitly to PDF workers, never stored in project records.
class AppLocaleData {
  const AppLocaleData({
    this.choice = 'system',
    this.deviceLocales = const [Locale('en', 'US')],
    this.use24HourClock,
  });

  final String choice;
  final List<Locale> deviceLocales;
  final bool? use24HourClock;

  Locale get uiLocale => choice == 'system'
      ? resolveAppLocale(deviceLocales)
      : resolveAppLocale([localeFromTag(choice)]);

  Locale get regionLocale =>
      deviceLocales.firstOrNull ?? const Locale('en', 'US');

  String get formatLocale => Intl.verifiedLocale(
    regionLocale.toString(),
    DateFormat.localeExists,
    onFailure: (_) => 'en_US',
  )!;

  bool get is24Hour =>
      use24HourClock ?? DateFormat.jm(formatLocale).pattern!.contains('H');

  AppLocalizations get strings => lookupAppLocalizations(uiLocale);

  AppLocaleData withChoice(String value) => AppLocaleData(
    choice: value,
    deviceLocales: deviceLocales,
    use24HourClock: use24HourClock,
  );

  Map<String, Object?> toMessage() => {
    'choice': choice,
    'deviceLocales': deviceLocales
        .map((value) => value.toLanguageTag())
        .toList(),
    'use24HourClock': use24HourClock,
  };

  factory AppLocaleData.fromMessage(Map<Object?, Object?> value) =>
      AppLocaleData(
        choice: value['choice'] as String? ?? 'system',
        deviceLocales: (value['deviceLocales'] as List? ?? ['en-US'])
            .cast<String>()
            .map(localeFromTag)
            .toList(growable: false),
        use24HourClock: value['use24HourClock'] as bool?,
      );
}

/// Adapter for existing context-free labels. UI widgets use [stringsOf].
/// Long-running work captures [current] and uses [runWith] or sends a snapshot.
abstract final class AppLocale {
  static AppLocaleData _current = const AppLocaleData();
  static final Object _zoneKey = Object();

  static AppLocaleData get current =>
      Zone.current[_zoneKey] as AppLocaleData? ?? _current;

  static void install(AppLocaleData value) => _current = value;

  static T runWith<T>(AppLocaleData value, T Function() body) =>
      runZoned(body, zoneValues: {_zoneKey: value});

  static Future<void> initialize() => initializeDateFormatting();
}

AppLocalizations get appStrings => AppLocale.current.strings;

/// Depends on Flutter's locale so changing language rebuilds existing widgets
/// without replacing their state, text controllers, drafts or navigation stack.
AppLocalizations stringsOf(BuildContext context) =>
    Localizations.of<AppLocalizations>(context, AppLocalizations) ?? appStrings;

String userErrorMessage(Object? error) {
  if (error is StateError) return error.message.toString();
  if (error is ArgumentError && error.message != null) {
    return error.message.toString();
  }
  return appStrings.unexpectedError;
}
