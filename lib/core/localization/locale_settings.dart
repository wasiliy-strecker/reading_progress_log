import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_locale.dart';

abstract interface class LocaleSettingsRepository {
  Future<AppLocaleData> load();
  Future<void> saveChoice(String choice);
}

class PlatformLocaleSettingsRepository implements LocaleSettingsRepository {
  static const _channel = MethodChannel(
    'com.appfactory.strick_haekelbuch/localization',
  );
  static const _preferenceKey = 'app_language';
  bool get _native =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  @override
  Future<AppLocaleData> load() async {
    if (_native) {
      final data = await _channel.invokeMapMethod<Object?, Object?>(
        'getSettings',
      );
      return AppLocaleData.fromMessage(data ?? const {});
    }
    final preferences = await SharedPreferences.getInstance();
    final saved = preferences.getString(_preferenceKey) ?? 'system';
    return AppLocaleData(
      choice: appLanguageNames.containsKey(saved) ? saved : 'system',
      deviceLocales: WidgetsBinding.instance.platformDispatcher.locales,
      use24HourClock:
          WidgetsBinding.instance.platformDispatcher.alwaysUse24HourFormat
          ? true
          : null,
    );
  }

  @override
  Future<void> saveChoice(String choice) async {
    if (choice != 'system' && !appLanguageNames.containsKey(choice)) {
      throw ArgumentError.value(choice, 'choice');
    }
    if (_native) {
      final saved = await _channel.invokeMethod<bool>('setLanguage', {
        'choice': choice,
      });
      if (saved != true) throw StateError(appStrings.languageSaveFailed);
    } else {
      final preferences = await SharedPreferences.getInstance();
      if (!await preferences.setString(_preferenceKey, choice)) {
        throw StateError(appStrings.languageSaveFailed);
      }
    }
  }
}

final initialLocaleProvider = Provider<AppLocaleData>(
  (ref) => AppLocale.current,
);
final localeSettingsRepositoryProvider = Provider<LocaleSettingsRepository>(
  (ref) => PlatformLocaleSettingsRepository(),
);
final appLocaleProvider = NotifierProvider<AppLocaleController, AppLocaleData>(
  AppLocaleController.new,
);

class AppLocaleController extends Notifier<AppLocaleData> {
  @override
  AppLocaleData build() => ref.watch(initialLocaleProvider);

  Future<void> choose(String choice) async {
    await ref.read(localeSettingsRepositoryProvider).saveChoice(choice);
    // Publish only after persistence succeeds. This is the same preference the
    // native reminder receiver reads when no Flutter process is running.
    final next = state.withChoice(choice);
    AppLocale.install(next);
    state = next;
  }

  Future<void> refreshDeviceSettings() async {
    try {
      final next = await ref.read(localeSettingsRepositoryProvider).load();
      AppLocale.install(next);
      state = next;
    } on Object {
      // Keep the last successful preference during a transient platform error.
    }
  }
}
