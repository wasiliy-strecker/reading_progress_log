import 'core/localization/app_locale.dart';
import 'core/localization/locale_settings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/files/photo_draft_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'app/app.dart';
import 'app/app_providers.dart';
import 'core/reminders/local_notification_reminder_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppLocale.initialize();
  final localeSettings = PlatformLocaleSettingsRepository();
  final locale = await localeSettings.load();
  AppLocale.install(locale);
  final appVersion = await _loadAppVersion();
  final photoDraftStore = PreferencesPhotoDraftStore(
    await SharedPreferences.getInstance(),
  );
  final photoDraftRoute = await photoDraftStore.pendingRoute();
  await LocalNotificationReminderRepository.instance.initialize();
  runApp(
    ProviderScope(
      overrides: [
        initialLocaleProvider.overrideWithValue(locale),
        localeSettingsRepositoryProvider.overrideWithValue(localeSettings),
        appVersionProvider.overrideWithValue(appVersion),
        photoDraftStoreProvider.overrideWithValue(photoDraftStore),
        initialPhotoDraftRouteProvider.overrideWithValue(photoDraftRoute),
      ],
      child: const MeterReadingLogApp(),
    ),
  );
}

Future<String> _loadAppVersion() async {
  try {
    return (await PackageInfo.fromPlatform()).version;
  } on Object {
    return '';
  }
}
