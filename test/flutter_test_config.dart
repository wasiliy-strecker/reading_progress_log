import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:strick_haekelbuch/core/localization/app_locale.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  await AppLocale.initialize();
  // Existing regression fixtures assert the original German presentation.
  // Locale-specific tests install their own explicit snapshot.
  AppLocale.install(
    const AppLocaleData(
      choice: 'de',
      deviceLocales: [Locale('de', 'DE')],
      use24HourClock: true,
    ),
  );
  await testMain();
}
