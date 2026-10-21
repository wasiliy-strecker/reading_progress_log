import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:strick_haekelbuch/core/localization/app_locale.dart';
import 'package:strick_haekelbuch/core/localization/locale_settings.dart';
import 'package:strick_haekelbuch/core/localization/regional_calendar_delegate.dart';
import 'package:strick_haekelbuch/core/utils/formatters.dart';
import 'package:strick_haekelbuch/features/meters/domain/meter.dart';
import 'package:strick_haekelbuch/features/meters/domain/reading_value.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppLocaleData original;
  setUp(() => original = AppLocale.current);
  tearDown(() => AppLocale.install(original));

  test('system language uses preferred list order and English fallback', () {
    expect(
      resolveAppLocale([
        const Locale('sv'),
        const Locale('fr', 'CA'),
        const Locale('de'),
      ]),
      const Locale('fr'),
    );
    expect(
      resolveAppLocale([const Locale('en', 'GB'), const Locale('de', 'DE')]),
      const Locale('en'),
    );
    expect(
      resolveAppLocale([const Locale('nb'), const Locale('nn')]),
      const Locale('en'),
    );
    expect(resolveAppLocale([]), const Locale('en'));
    expect(
      resolveAppLocale([const Locale('pt', 'PT')]),
      const Locale('pt', 'BR'),
    );
  });

  test('all six catalogs have contextual unit labels and plural messages', () {
    const expectedRows = ['Row', 'Reihe', 'Fila', 'Rang', 'Riga', 'Carreira'];
    for (var index = 0; index < appSupportedLocales.length; index++) {
      final locale = appSupportedLocales[index];
      AppLocale.install(AppLocaleData(choice: locale.toLanguageTag()));
      expect(appStrings.row, expectedRows[index]);
      expect(appStrings.entryCount(1), isNot(appStrings.entryCount(2)));
      for (final countText in [
        appStrings.entryCount(0),
        appStrings.projectCount(0),
        appStrings.reportCount(0),
        appStrings.photoCount(0),
        appStrings.matchCount(0),
        appStrings.includedEntries(0),
      ]) {
        expect(countText, startsWith('0'));
      }
      expect(
        appStrings.photosAddedNotProcessed(0, 'x'),
        isNot(appStrings.photosAddedNotProcessed(1, 'x')),
      );
      expect(appStrings.photosForProgressEntry(0, '48'), startsWith('0'));
      expect(progressUnitLabel('custom unit'), 'custom unit');
      expect(MeterType.knitting.defaultUnit, 'Reihen');
      expect(MeterType.crochet.availableUnits, ['Reihen', 'Runden']);
      expect(MeterType.knitting.wireName, 'knitting');
    }
  });

  test('manual English keeps German number and date input conventions', () {
    AppLocale.install(
      const AppLocaleData(
        choice: 'en',
        deviceLocales: [Locale('de', 'DE')],
        use24HourClock: true,
      ),
    );
    expect(appStrings.settings, 'Settings');
    expect(
      formatReadingValue(
        const ReadingValue(
          displayText: 'legacy',
          digits: '900719925474099312345',
          scale: 3,
        ),
      ),
      '900.719.925.474.099.312,345',
    );
    expect(formatDecimal(4.5), '4,5');
    expect(formatClockTime(16, 7), '16:07');
    expect(formatDate(DateTime(2026, 10, 21)), '21.10.2026');
    final calendar = RegionalCalendarDelegate();
    const material = DefaultMaterialLocalizations();
    expect(
      calendar.parseCompactDate('21.10.2026', material),
      DateTime(2026, 10, 21),
    );
    expect(calendar.parseCompactDate('10/21/2026', material), isNull);
    expect(calendar.parseCompactDate('31.02.2026', material), isNull);
  });

  test('US region and Brazilian region retain exact legacy decimals', () {
    const value = ReadingValue(
      displayText: '1.234,500',
      digits: '1234500',
      scale: 3,
    );
    final saved = value.toJson();
    AppLocale.install(
      const AppLocaleData(
        choice: 'de',
        deviceLocales: [Locale('en', 'US')],
        use24HourClock: false,
      ),
    );
    expect(formatReadingValue(value), '1,234.500');
    expect(formatClockTime(16, 7), contains('4:07'));
    expect(normalizeHistoryQuery('10/21/2026'), '21.10.2026');
    expect(normalizeHistoryQuery('1234'), '1234');
    expect(normalizeHistoryQuery('note 10/21/2026'), 'note 10/21/2026');
    AppLocale.install(
      const AppLocaleData(choice: 'en', deviceLocales: [Locale('pt', 'BR')]),
    );
    expect(formatReadingValue(value), '1.234,500');
    expect(value.toJson(), saved);
    expect(ReadingValue.tryParseEdit('1.234,500', value), same(value));
    expect(ReadingValue.tryParseWhole('1,5'), isNull);
    expect(ReadingValue.tryParseWhole('-1'), isNull);
    expect(
      ReadingValue.tryParseWhole('12345678901234567890')!.digits,
      '12345678901234567890',
    );
  });

  test(
    'preference survives a new controller and write failures keep the selection',
    () async {
      final repository = _MemorySettings();
      Future<ProviderContainer> start() async => ProviderContainer(
        overrides: [
          initialLocaleProvider.overrideWithValue(await repository.load()),
          localeSettingsRepositoryProvider.overrideWithValue(repository),
        ],
      );
      final first = await start();
      await first.read(appLocaleProvider.notifier).choose('fr');
      expect(first.read(appLocaleProvider).uiLocale, const Locale('fr'));
      first.dispose();
      final second = await start();
      addTearDown(second.dispose);
      expect(second.read(appLocaleProvider).choice, 'fr');
      repository.failWrites = true;
      await expectLater(
        second.read(appLocaleProvider.notifier).choose('it'),
        throwsStateError,
      );
      expect(second.read(appLocaleProvider).choice, 'fr');
      repository.failWrites = false;
      await second.read(appLocaleProvider.notifier).choose('system');
      expect(second.read(appLocaleProvider).uiLocale, const Locale('de'));
    },
  );

  test(
    'Android bridge persists preference and reads independent device locales',
    () async {
      const channel = MethodChannel(
        'com.appfactory.strick_haekelbuch/localization',
      );
      var preference = 'system';
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (call) async {
            if (call.method == 'setLanguage') {
              preference = (call.arguments as Map)['choice'] as String;
              return true;
            }
            return {
              'choice': preference,
              'deviceLocales': ['de-DE', 'en-US'],
              'use24HourClock': true,
            };
          });
      addTearDown(
        () => TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(channel, null),
      );
      final repository = PlatformLocaleSettingsRepository();
      await repository.saveChoice('en');
      final loaded = await PlatformLocaleSettingsRepository().load();
      expect(loaded.choice, 'en');
      expect(loaded.uiLocale, const Locale('en'));
      expect(loaded.regionLocale, const Locale('de', 'DE'));
    },
  );

  test(
    'operation snapshots remain stable across concurrent language changes',
    () async {
      const english = AppLocaleData(
        choice: 'en',
        deviceLocales: [Locale('de', 'DE')],
      );
      final result = AppLocale.runWith(english, () async {
        await Future<void>.delayed(Duration.zero);
        return appStrings.settings;
      });
      AppLocale.install(const AppLocaleData(choice: 'fr'));
      expect(await result, 'Settings');
      expect(appStrings.settings, 'Paramètres');
    },
  );
}

class _MemorySettings implements LocaleSettingsRepository {
  var choice = 'system';
  var failWrites = false;
  @override
  Future<AppLocaleData> load() async =>
      AppLocaleData(choice: choice, deviceLocales: const [Locale('de', 'DE')]);
  @override
  Future<void> saveChoice(String value) async {
    if (failWrites) throw StateError('write failed');
    choice = value;
  }
}
