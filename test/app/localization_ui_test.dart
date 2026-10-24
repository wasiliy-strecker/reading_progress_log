import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:strick_haekelbuch/app/app.dart';
import 'package:strick_haekelbuch/app/app_providers.dart';
import 'package:strick_haekelbuch/app/app_router.dart';
import 'package:strick_haekelbuch/core/localization/app_locale.dart';
import 'package:strick_haekelbuch/core/localization/locale_settings.dart';
import 'package:strick_haekelbuch/features/backup/presentation/settings_screen.dart';
import 'package:strick_haekelbuch/features/meters/presentation/meter_form_screen.dart';
import '../support/fakes.dart';
import '../support/reading_fixtures.dart';

void main() {
  late AppLocaleData original;
  setUp(() => original = AppLocale.current);
  tearDown(() => AppLocale.install(original));

  for (final choice in appLanguageNames.keys) {
    for (final scale in [1.0, 1.6]) {
      testWidgets(
        '$choice settings and project form fit a narrow screen at $scale',
        (tester) async {
          final locale = AppLocaleData(
            choice: choice,
            deviceLocales: const [Locale('de', 'DE')],
          );
          AppLocale.install(locale);
          await tester.binding.setSurfaceSize(const Size(360, 800));
          addTearDown(() => tester.binding.setSurfaceSize(null));
          Widget app(Widget child) => ProviderScope(
            overrides: [
              meterReminderRepositoryProvider.overrideWithValue(
                NoopMeterReminderRepository(),
              ),
            ],
            child: MaterialApp(
              locale: locale.uiLocale,
              supportedLocales: appSupportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(textScaler: TextScaler.linear(scale)),
                child: child!,
              ),
              home: child,
            ),
          );
          await tester.pumpWidget(app(const SettingsScreen()));
          await tester.pumpAndSettle();
          expect(find.text(locale.strings.language), findsOneWidget);
          expect(tester.takeException(), isNull);
          await tester.scrollUntilVisible(
            find.byKey(const ValueKey('open-privacy-policy')),
            250,
          );
          await tester.scrollUntilVisible(
            find.byKey(const ValueKey('open-source-code')),
            250,
          );
          expect(find.text(locale.strings.sourceCodeOnGitHub), findsOneWidget);
          expect(find.text(locale.strings.openSourceMPL20), findsOneWidget);
          expect(tester.takeException(), isNull);
          await tester.pumpWidget(app(const MeterFormScreen()));
          await tester.pumpAndSettle();
          expect(find.text(locale.strings.projectName224), findsOneWidget);
          expect(tester.takeException(), isNull);
          await tester.ensureVisible(find.text(locale.strings.saveProject));
          expect(tester.takeException(), isNull);
        },
      );
    }
  }

  testWidgets('changing language retains a draft, route and stored values', (
    tester,
  ) async {
    final settings = _Settings();
    final meter = sampleBook(label: 'Mein eigener Name');
    final meters = MemoryMeterRepository()..items[meter.id] = meter;
    final container = ProviderContainer(
      overrides: [
        initialLocaleProvider.overrideWithValue(await settings.load()),
        localeSettingsRepositoryProvider.overrideWithValue(settings),
        meterRepositoryProvider.overrideWithValue(meters),
        meterReadingRepositoryProvider.overrideWithValue(
          MemoryReadingRepository(),
        ),
        evidenceExportRepositoryProvider.overrideWithValue(
          MemoryEvidenceExportRepository(),
        ),
        meterReminderRepositoryProvider.overrideWithValue(
          NoopMeterReminderRepository(),
        ),
      ],
    );
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MeterReadingLogApp(),
      ),
    );
    await tester.pumpAndSettle();
    container.read(appRouterProvider).go('/meter/${meter.id}/edit');
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Projektname *'),
      'Unveränderte eigene Notiz',
    );
    await container.read(appLocaleProvider.notifier).choose('en');
    await tester.pumpAndSettle();
    expect(find.text('Unveränderte eigene Notiz'), findsOneWidget);
    expect(find.text('Project name *'), findsOneWidget);
    expect(
      container.read(appRouterProvider).state.uri.path,
      '/meter/${meter.id}/edit',
    );
    expect(meters.items[meter.id]!.label, 'Mein eigener Name');
    expect(meters.items[meter.id]!.unit, 'Reihen');
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'language selector is available in normal settings and applies immediately',
    (tester) async {
      final settings = _Settings();
      final container = ProviderContainer(
        overrides: [
          initialLocaleProvider.overrideWithValue(await settings.load()),
          localeSettingsRepositoryProvider.overrideWithValue(settings),
          meterRepositoryProvider.overrideWithValue(MemoryMeterRepository()),
          meterReadingRepositoryProvider.overrideWithValue(
            MemoryReadingRepository(),
          ),
          evidenceExportRepositoryProvider.overrideWithValue(
            MemoryEvidenceExportRepository(),
          ),
          meterReminderRepositoryProvider.overrideWithValue(
            NoopMeterReminderRepository(),
          ),
        ],
      );
      addTearDown(container.dispose);
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MeterReadingLogApp(),
        ),
      );
      await tester.pumpAndSettle();
      container.read(appRouterProvider).go('/settings');
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('app-language-selector')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('English').last);
      await tester.pumpAndSettle();
      expect(find.text('Settings'), findsOneWidget);
      expect(settings.choice, 'en');
      expect(
        container.read(appLocaleProvider).regionLocale,
        const Locale('de', 'DE'),
      );
      expect(tester.takeException(), isNull);
    },
  );
}

class _Settings implements LocaleSettingsRepository {
  var choice = 'de';
  @override
  Future<AppLocaleData> load() async => AppLocaleData(
    choice: choice,
    deviceLocales: const [Locale('de', 'DE')],
    use24HourClock: true,
  );
  @override
  Future<void> saveChoice(String value) async {
    choice = value;
  }
}
