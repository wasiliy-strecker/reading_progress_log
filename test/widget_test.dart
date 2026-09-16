import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strick_haekelbuch/app/app.dart';
import 'package:strick_haekelbuch/app/app_providers.dart';
import 'package:strick_haekelbuch/core/files/meter_photo_repository.dart';
import 'package:strick_haekelbuch/core/reminders/local_notification_reminder_repository.dart';
import 'package:strick_haekelbuch/features/meters/domain/meter.dart';
import 'package:strick_haekelbuch/features/meters/domain/meter_reading.dart';
import 'package:strick_haekelbuch/features/meters/domain/reading_value.dart';

import 'support/fakes.dart';

void main() {
  testWidgets(
    'returning after permission regrant schedules saved values and preserves the open draft',
    (tester) async {
      final meter = Meter(
        id: 'recovery-project',
        label: 'Gespeicherter Schal',
        type: MeterType.knitting,
        unit: 'Reihen',
        meterNumber: '',
        location: '',
        createdAt: DateTime.utc(2026),
        updatedAt: DateTime.utc(2026),
        reminder: const ReadingReminderSchedule(
          interval: ReminderInterval.daily,
          day: 1,
          hour: 9,
          minute: 0,
        ),
      );
      final meters = MemoryMeterRepository()..items[meter.id] = meter;
      final reminders = NoopMeterReminderRepository(
        permission: ReminderPermissionStatus.denied,
      );
      await tester.pumpWidget(_testApp(meters: meters, reminders: reminders));
      await tester.pumpAndSettle();
      await tester.tap(find.text(meter.label));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Projekt & Erinnerung bearbeiten'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Projektname *'),
        'Noch nicht gespeichert',
      );
      final before = reminders.scheduledMeters.length;
      reminders.permission = ReminderPermissionStatus.granted;
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pumpAndSettle();
      expect(reminders.scheduledMeters, hasLength(before + 1));
      expect(reminders.scheduledMeters.last.label, 'Gespeicherter Schal');
      expect(meters.items[meter.id]!.label, 'Gespeicherter Schal');
      expect(find.text('Noch nicht gespeichert'), findsOneWidget);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pumpAndSettle();
      expect(reminders.scheduledMeters, hasLength(before + 1));
      expect(tester.takeException(), isNull);
    },
  );

  for (final appBlocked in [true, false]) {
    for (final editing in [true, false]) {
      testWidgets(
        'saving with blocked notifications keeps project and offers settings: app=$appBlocked edit=$editing',
        (tester) async {
          await tester.binding.setSurfaceSize(const Size(430, 1100));
          addTearDown(() => tester.binding.setSurfaceSize(null));
          final meters = MemoryMeterRepository();
          final reminders = NoopMeterReminderRepository(
            permission: appBlocked
                ? ReminderPermissionStatus.denied
                : ReminderPermissionStatus.granted,
            normalAvailability: appBlocked
                ? ReminderAvailability.available
                : ReminderAvailability.channelBlocked,
          );
          final existing = Meter(
            id: 'blocked-project',
            label: 'Wollprojekt',
            type: MeterType.knitting,
            unit: 'Reihen',
            meterNumber: '',
            location: '',
            createdAt: DateTime.utc(2026),
            updatedAt: DateTime.utc(2026),
            reminder: const ReadingReminderSchedule(
              interval: ReminderInterval.daily,
              day: 1,
              hour: 9,
              minute: 0,
            ),
          );
          if (editing) meters.items[existing.id] = existing;
          await tester.pumpWidget(
            _testApp(meters: meters, reminders: reminders),
          );
          await tester.pumpAndSettle();
          if (editing) {
            await tester.tap(find.text('Wollprojekt'));
            await tester.pumpAndSettle();
            await tester.tap(find.text('Projekt & Erinnerung bearbeiten'));
          } else {
            await tester.tap(find.text('Projekt anlegen'));
          }
          await tester.pumpAndSettle();
          await tester.enterText(
            find.widgetWithText(TextFormField, 'Projektname *'),
            'Mein Schal',
          );
          await tester.pumpAndSettle();
          if (!editing) {
            await tester.scrollUntilVisible(
              find.text('Projekterinnerung'),
              250,
              scrollable: find.byType(Scrollable).first,
            );
            await tester.tap(find.text('Projekterinnerung'));
            await tester.pumpAndSettle();
          }
          await tester.tap(
            find.text(editing ? 'Änderungen speichern' : 'Projekt speichern'),
          );
          await tester.pumpAndSettle();
          expect(meters.items.values.single.label, 'Mein Schal');
          expect(meters.items.values.single.reminder, isNotNull);
          expect(
            find.text(
              'Projekt gespeichert. Erinnerungen sind in Android blockiert.',
            ),
            findsOneWidget,
          );
          await tester.tap(
            find.widgetWithText(SnackBarAction, 'Einstellungen'),
          );
          await tester.pumpAndSettle();
          expect(reminders.notificationSettingsOpened, [
            appBlocked ? null : ReminderDeliveryMode.normal,
          ]);
          expect(tester.takeException(), isNull);
        },
      );
    }
  }

  testWidgets('empty app opens meter creation flow', (tester) async {
    await tester.pumpWidget(_testApp());
    await tester.pumpAndSettle();

    expect(find.text('Erstes Projekt anlegen'), findsOneWidget);
    expect(
      find.textContaining('Vom ersten Anschlag bis zur letzten Masche:'),
      findsOneWidget,
    );
    expect(find.textContaining('OCR-Daten'), findsNothing);
    await tester.tap(find.text('Projekt anlegen'));
    await tester.pumpAndSettle();

    expect(find.text('Technik'), findsOneWidget);
    expect(find.text('Projektname *'), findsOneWidget);
    expect(find.text('Zählweise *'), findsOneWidget);
    expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Projekterinnerung'),
      180,
      scrollable: find
          .descendant(
            of: find.byType(ListView),
            matching: find.byType(Scrollable),
          )
          .first,
    );
    expect(find.text('Projekterinnerung'), findsOneWidget);
    expect(
      tester.widget<ListView>(find.byType(ListView)).keyboardDismissBehavior,
      ScrollViewKeyboardDismissBehavior.onDrag,
    );
  });

  testWidgets('reminder time uses a clearly clickable full-width button', (
    tester,
  ) async {
    await tester.pumpWidget(_testApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Projekt anlegen'));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Projekterinnerung'),
      180,
      scrollable: find
          .descendant(
            of: find.byType(ListView),
            matching: find.byType(Scrollable),
          )
          .first,
    );
    await tester.ensureVisible(find.byType(SwitchListTile));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(SwitchListTile));
    await tester.pumpAndSettle();
    final timeButton = find.widgetWithText(OutlinedButton, 'Uhrzeit ändern');
    expect(
      tester.widget<SwitchListTile>(find.byType(SwitchListTile)).value,
      isTrue,
    );
    await tester.scrollUntilVisible(
      timeButton,
      150,
      scrollable: find.byType(Scrollable).first,
    );
    expect(timeButton, findsOneWidget);
    await tester.ensureVisible(timeButton);
    await tester.pumpAndSettle();
    expect(
      tester.getSize(timeButton).width,
      greaterThan(tester.getSize(find.text('Uhrzeit ändern')).width * 2),
    );

    await tester.tap(timeButton);
    await tester.pumpAndSettle();
    expect(find.byType(TimePickerDialog), findsOneWidget);
  });

  testWidgets('reminders support dev, daily and weekly intervals', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(430, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final meters = MemoryMeterRepository();
    await tester.pumpWidget(_testApp(meters: meters));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Projekt anlegen'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Projektname *'),
      'Wasser wöchentlich',
    );

    await tester.tap(find.text('Projekterinnerung'));
    await tester.pumpAndSettle();
    expect(
      find.text(
        'Kann leicht verzögert erscheinen. Die Systemeinstellung „Nicht stören“ wird berücksichtigt.',
      ),
      findsOneWidget,
    );
    final intervalField = find.byType(
      DropdownButtonFormField<ReminderInterval>,
    );
    await tester.ensureVisible(intervalField);
    await tester.tap(intervalField);
    await tester.pumpAndSettle();
    expect(find.text('Minütlich (Dev)'), findsOneWidget);
    expect(find.text('Täglich'), findsOneWidget);
    expect(find.text('Wöchentlich'), findsOneWidget);

    await tester.tap(find.text('Minütlich (Dev)'));
    await tester.pumpAndSettle();
    expect(
      find.text(
        'Dev-Modus: Die nächste Erinnerung wird zum Beginn der nächsten Minute geplant. Normale Erinnerungen können leicht verzögert erscheinen.',
      ),
      findsOneWidget,
    );
    expect(find.text('Uhrzeit ändern'), findsNothing);

    await tester.tap(intervalField);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Täglich'));
    await tester.pumpAndSettle();
    expect(find.text('Wochentag'), findsNothing);
    expect(find.text('Tag'), findsNothing);

    await tester.tap(intervalField);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Wöchentlich').last);
    await tester.pumpAndSettle();
    expect(find.text('Wochentag'), findsOneWidget);

    final weekdayField = find.byType(DropdownButtonFormField<int>);
    await tester.tap(weekdayField);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Montag').last);
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Projekt speichern'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Projekt speichern'));
    for (var attempt = 0; attempt < 30 && meters.items.isEmpty; attempt++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    await tester.pump();

    final reminder = meters.items.values.single.reminder!;
    expect(reminder.interval, ReminderInterval.weekly);
    expect(reminder.day, DateTime.monday);
  });

  testWidgets('hourly reminder saves an editable start date and time', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(430, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final meters = MemoryMeterRepository();
    final reminders = NoopMeterReminderRepository();
    await tester.pumpWidget(_testApp(meters: meters, reminders: reminders));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Projekt anlegen'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Projektname *'),
      'Strom stündlich',
    );
    await tester.tap(find.text('Projekterinnerung'));
    await tester.pumpAndSettle();
    final interval = find.byType(DropdownButtonFormField<ReminderInterval>);
    await tester.tap(interval);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Stündlich').last);
    await tester.pumpAndSettle();
    expect(find.text('Startdatum'), findsOneWidget);
    expect(find.text('Startzeit'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('hourly-pick-date')));
    await tester.pumpAndSettle();
    tester
        .widget<CalendarDatePicker>(find.byType(CalendarDatePicker))
        .onDateChanged(DateTime(2030, 9, 15));
    await tester.pump();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(find.text('15.09.2030'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('hourly-pick-time')));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.keyboard_outlined));
    await tester.pumpAndSettle();
    final inputs = find.descendant(
      of: find.byType(TimePickerDialog),
      matching: find.byType(TextFormField),
    );
    await tester.enterText(inputs.at(0), '14');
    await tester.enterText(inputs.at(1), '30');
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(find.text('14:30'), findsOneWidget);
    await tester.tap(find.text('Projekt speichern'));
    await tester.pumpAndSettle();
    final stored = meters.items.values.single.reminder!;
    expect(stored.interval, ReminderInterval.hourly);
    expect(stored.startsAt, DateTime(2030, 9, 15, 14, 30).toUtc());
    expect(reminders.scheduledMeters.last.reminder!.startsAt, stored.startsAt);
  });

  testWidgets('normal reminder test shows progress and uses meter details', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(430, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final meter =
        _meter(
          id: 'reminder_test_meter',
          label: 'Strom Keller',
          type: MeterType.knitting,
          location: 'Keller',
          updatedAt: DateTime.utc(2026, 9, 5),
        ).copyWith(
          reminder: const ReadingReminderSchedule(
            interval: ReminderInterval.daily,
            day: 1,
            hour: 9,
            minute: 0,
          ),
        );
    final meters = MemoryMeterRepository()..items[meter.id] = meter;
    final reading = _reading(
      meter: meter,
      updatedAt: DateTime.utc(2026, 9, 5, 10),
    );
    final readings = MemoryReadingRepository()..items[reading.id] = reading;
    final reminders = _PendingReminderTestRepository();
    await tester.pumpWidget(
      _testApp(meters: meters, readings: readings, reminders: reminders),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Strom Keller'));
    await tester.pumpAndSettle();
    await tester.tap(
      find.widgetWithText(OutlinedButton, 'Projekt & Erinnerung bearbeiten'),
    );
    await tester.pumpAndSettle();

    final button = find.widgetWithText(
      OutlinedButton,
      'Erinnerung jetzt testen',
    );
    await tester.scrollUntilVisible(
      button,
      250,
      scrollable: find.byType(Scrollable).last,
    );
    expect(button, findsOneWidget);
    expect(find.text('Ton jetzt testen'), findsNothing);
    await tester.tap(button);
    await tester.pump();

    expect(reminders.reminderTests, hasLength(1));
    final request = reminders.reminderTests.single;
    expect(request.deliveryMode, ReminderDeliveryMode.normal);
    expect(request.meterId, meter.id);
    expect(request.label, meter.label);
    expect(request.meterType, MeterType.knitting);
    expect(request.latestValue, reading.value.displayText);
    expect(request.latestUnit, reading.meter.unit);
    expect(
      find.descendant(
        of: button,
        matching: find.byType(CircularProgressIndicator),
      ),
      findsOneWidget,
    );
    expect(tester.widget<OutlinedButton>(button).onPressed, isNull);

    reminders.completeTest(ReminderTestResult.posted);
    await tester.pumpAndSettle();
    expect(
      find.text(
        'Test-Erinnerung wurde an Android übergeben. Ziehe die Benachrichtigungsleiste herunter. Die Test-Erinnerung verschwindet nach einer Minute.',
      ),
      findsOneWidget,
    );
  });

  testWidgets(
    'punctual reminder uses the same test button and reports denial',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(430, 1800));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final reminders = NoopMeterReminderRepository(
        reminderTestResult: ReminderTestResult.failed,
        permission: ReminderPermissionStatus.denied,
        exactAlarmPermissionGranted: false,
      );
      await tester.pumpWidget(_testApp(reminders: reminders));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Projekt anlegen'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Projektname *'),
        'Strom pünktlich',
      );

      await tester.tap(find.text('Projekterinnerung'));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Pünktlich mit Ton'));
      await tester.tap(find.text('Pünktlich mit Ton'));
      await tester.pumpAndSettle();

      final punctualMode = find.byKey(const ValueKey('reminder-mode-punctual'));
      expect(
        find.descendant(
          of: punctualMode,
          matching: find.byIcon(Icons.check_circle),
        ),
        findsOneWidget,
      );
      expect(reminders.exactAlarmPermissionRequestCount, 1);
      expect(find.text('Alarme & Erinnerungen erlauben'), findsNothing);

      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pumpAndSettle();

      expect(
        find.textContaining('Für pünktliche Erinnerungen muss Android'),
        findsOneWidget,
      );
      final allowExactAlarms = find.widgetWithText(
        TextButton,
        'Alarme & Erinnerungen erlauben',
      );
      expect(allowExactAlarms, findsOneWidget);
      await tester.ensureVisible(allowExactAlarms);
      await tester.tap(allowExactAlarms);
      await tester.pumpAndSettle();
      expect(reminders.exactAlarmPermissionRequestCount, 2);
      expect(find.text('Alarme & Erinnerungen erlauben'), findsNothing);

      reminders.exactAlarmPermissionGranted = true;
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pumpAndSettle();
      expect(
        find.textContaining('Für pünktliche Erinnerungen muss Android'),
        findsNothing,
      );
      final alarmSettings = find.widgetWithText(
        OutlinedButton,
        '„Alarme & Erinnerungen“ öffnen',
      );
      expect(alarmSettings, findsOneWidget);
      await tester.tap(alarmSettings);
      await tester.pump();
      expect(reminders.exactAlarmSettingsOpenCount, 1);
      expect(find.text('Ton jetzt testen'), findsNothing);
      expect(find.text('Erinnerung jetzt testen'), findsOneWidget);
      await tester.tap(find.text('Erinnerung jetzt testen'));
      await tester.pumpAndSettle();
      expect(reminders.reminderTests, hasLength(1));
      expect(
        reminders.reminderTests.single.deliveryMode,
        ReminderDeliveryMode.punctualWithSound,
      );
      expect(
        find.text('Benachrichtigungen sind nicht erlaubt.'),
        findsOneWidget,
      );
    },
  );

  for (final technique in MeterType.values) {
    for (final unit in ['Reihen', 'Runden']) {
      testWidgets('project saves metadata with ${technique.name} / $unit', (
        tester,
      ) async {
        await tester.binding.setSurfaceSize(const Size(430, 1100));
        addTearDown(() => tester.binding.setSurfaceSize(null));
        final meters = MemoryMeterRepository();
        await tester.pumpWidget(_testApp(meters: meters));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Projekt anlegen'));
        await tester.pumpAndSettle();
        await tester.enterText(
          find.widgetWithText(TextFormField, 'Projektname *'),
          'Salbei-Pullover',
        );
        await tester.enterText(
          find.widgetWithText(TextFormField, 'Garn (optional)'),
          'Merinowolle',
        );
        await tester.enterText(
          find.widgetWithText(TextFormField, 'Nadelstärke (optional)'),
          '4,5 mm',
        );
        FocusManager.instance.primaryFocus?.unfocus();
        await tester.pumpAndSettle();
        final units = find.byType(DropdownButtonFormField<String>);
        await tester.ensureVisible(units);
        await tester.tap(units);
        await tester.pumpAndSettle();
        expect(find.text('Weitere Einheit …'), findsNothing);
        await tester.tap(find.text(unit).last);
        await tester.pumpAndSettle();
        final techniques = find.byType(DropdownButtonFormField<MeterType>);
        await tester.ensureVisible(techniques);
        await tester.tap(techniques);
        await tester.pumpAndSettle();
        expect(find.text('Stricken'), findsWidgets);
        expect(find.text('Häkeln'), findsWidgets);
        await tester.tap(find.text(technique.label).last);
        await tester.pumpAndSettle();
        // Choosing the technique must preserve the user's prior counting unit.
        expect(find.text(unit), findsOneWidget);
        final save = find.text('Projekt speichern');
        await tester.ensureVisible(save);
        await tester.tap(save);
        await tester.pumpAndSettle();
        final saved = meters.items.values.single;
        expect(saved.type, technique);
        expect(saved.unit, unit);
        expect(saved.label, 'Salbei-Pullover');
        expect(saved.meterNumber, 'Merinowolle');
        expect(saved.location, '4,5 mm');
        expect(saved.reminder, isNull);
        expect(tester.takeException(), isNull);
      });
    }
  }

  testWidgets('new meter confirms that reading follows next', (tester) async {
    final meters = MemoryMeterRepository();
    await tester.pumpWidget(_testApp(meters: meters));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Projekt anlegen'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Projektname *'),
      'Strom HauptProjekt',
    );
    await tester.ensureVisible(find.text('Projekt speichern'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Projekt speichern'));
    const confirmation =
        'Projekt gespeichert. Als Nächstes kannst du den ersten Projektstand erfassen.';
    for (var attempt = 0; attempt < 30; attempt++) {
      await tester.pump(const Duration(milliseconds: 100));
      if (find.text(confirmation).evaluate().isNotEmpty) break;
    }

    expect(meters.items.values.single.label, 'Strom HauptProjekt');
    expect(find.text(confirmation), findsWidgets);
    expect(find.text('Projektstand erfassen'), findsOneWidget);

    expect(await tester.binding.handlePopRoute(), isTrue);
    await tester.pumpAndSettle();

    expect(find.text('Strick & Häkelbuch'), findsOneWidget);
    expect(find.text('Projektstand erfassen'), findsNothing);
  });

  testWidgets('meter edit and delete actions are visible below its summary', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(430, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final meters = MemoryMeterRepository();
    final meter =
        _meter(
          id: 'weekly_meter',
          label: 'Wasser Garten',
          type: MeterType.knitting,
          location: 'Garten',
          updatedAt: DateTime.utc(2026, 9, 4),
        ).copyWith(
          reminder: const ReadingReminderSchedule(
            interval: ReminderInterval.weekly,
            day: DateTime.friday,
            hour: 9,
            minute: 0,
          ),
        );
    meters.items[meter.id] = meter;

    await tester.pumpWidget(_testApp(meters: meters));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Wasser Garten'));
    await tester.pumpAndSettle();

    final edit = find.widgetWithText(
      OutlinedButton,
      'Projekt & Erinnerung bearbeiten',
    );
    final delete = find.widgetWithText(OutlinedButton, 'Projekt löschen');
    expect(edit, findsOneWidget);
    expect(delete, findsOneWidget);
    expect(find.byType(PopupMenuButton<String>), findsNothing);
    expect(
      find.text('Erinnerung: wöchentlich am Freitag um 09:00 Uhr'),
      findsOneWidget,
    );
    expect(
      tester.getBottomLeft(find.byType(Card).first).dy,
      lessThan(tester.getTopLeft(edit).dy),
    );
    expect(
      tester.getTopLeft(delete).dy,
      lessThan(tester.getTopLeft(find.text('Projektverlauf')).dy),
    );

    await tester.tap(find.byKey(const ValueKey('meter-summary-weekly_meter')));
    await tester.pumpAndSettle();
    expect(find.text('Projekt bearbeiten'), findsOneWidget);
  });

  testWidgets('meter edit keeps save visible and protects unsaved changes', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(430, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final meters = MemoryMeterRepository();
    final meter = _meter(
      id: 'protected_meter',
      label: 'Strom Keller',
      type: MeterType.knitting,
      location: 'Keller',
      updatedAt: DateTime.utc(2026, 9, 4),
    );
    meters.items[meter.id] = meter;

    await tester.pumpWidget(_testApp(meters: meters));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Strom Keller'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Projekt & Erinnerung bearbeiten'));
    await tester.pumpAndSettle();

    final savedButton = find.widgetWithText(FilledButton, 'Alles gespeichert');
    expect(savedButton, findsOneWidget);
    expect(savedButton.hitTestable(), findsOneWidget);
    expect(tester.widget<FilledButton>(savedButton).onPressed, isNull);

    final labelField = find.widgetWithText(TextFormField, 'Projektname *');
    await tester.enterText(labelField, 'Strom HauptProjekt');
    await tester.pump();
    final saveButton = find.widgetWithText(
      FilledButton,
      'Änderungen speichern',
    );
    expect(saveButton, findsOneWidget);
    expect(tester.widget<FilledButton>(saveButton).onPressed, isNotNull);

    expect(await tester.binding.handlePopRoute(), isTrue);
    await tester.pumpAndSettle();
    expect(find.text('Änderungen verwerfen?'), findsOneWidget);
    expect(
      find.text(
        'Deine Änderungen an diesem Projekt wurden noch nicht gespeichert.',
      ),
      findsOneWidget,
    );

    await tester.tap(find.text('Weiter bearbeiten'));
    await tester.pumpAndSettle();
    expect(find.text('Projekt bearbeiten'), findsOneWidget);
    expect(
      tester.widget<TextFormField>(labelField).controller?.text,
      'Strom HauptProjekt',
    );

    expect(await tester.binding.handlePopRoute(), isTrue);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Änderungen verwerfen'));
    await tester.pumpAndSettle();

    expect(find.text('Projekt bearbeiten'), findsNothing);
    expect(meters.items[meter.id]!.label, 'Strom Keller');
  });

  testWidgets('selecting minutely enables saving for a changed reminder', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(430, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final meter =
        _meter(
          id: 'daily_meter',
          label: 'Strom täglich',
          type: MeterType.knitting,
          location: 'Keller',
          updatedAt: DateTime.utc(2026, 9, 4),
        ).copyWith(
          reminder: const ReadingReminderSchedule(
            interval: ReminderInterval.daily,
            day: 1,
            hour: 6,
            minute: 0,
          ),
        );
    final meters = MemoryMeterRepository()..items[meter.id] = meter;

    await tester.pumpWidget(_testApp(meters: meters));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Strom täglich'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Projekt & Erinnerung bearbeiten'));
    await tester.pumpAndSettle();

    expect(
      tester
          .widget<FilledButton>(
            find.widgetWithText(FilledButton, 'Alles gespeichert'),
          )
          .onPressed,
      isNull,
    );

    final intervalField = find.byType(
      DropdownButtonFormField<ReminderInterval>,
    );
    await tester.tap(intervalField);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Minütlich (Dev)').last);
    await tester.pumpAndSettle();

    final saveButton = find.widgetWithText(
      FilledButton,
      'Änderungen speichern',
    );
    expect(saveButton, findsOneWidget);
    expect(tester.widget<FilledButton>(saveButton).onPressed, isNotNull);
  });

  testWidgets('system back returns from settings', (tester) async {
    await tester.pumpWidget(_testApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Einstellungen'));
    await tester.pumpAndSettle();
    expect(find.text('Einstellungen'), findsOneWidget);
    expect(find.text('PDF auf Änderungen prüfen'), findsNothing);
    expect(find.text('Nachweise'), findsNothing);
    expect(
      find.text(
        'Fotos, Projektstände und PDFs werden lokal auf deinem Gerät verarbeitet. Die App überträgt deine Projektdaten nicht an einen Server.',
      ),
      findsOneWidget,
    );
    expect(find.textContaining('OCR, Fotos'), findsNothing);

    expect(await tester.binding.handlePopRoute(), isTrue);
    await tester.pumpAndSettle();
    expect(find.text('Strick & Häkelbuch'), findsOneWidget);
  });

  testWidgets('notification meter has back button and edge back to dashboard', (
    tester,
  ) async {
    final meter = _meter(
      id: 'notification_meter',
      label: 'Strom aus Erinnerung',
      type: MeterType.knitting,
      location: 'Keller',
      updatedAt: DateTime.utc(2026, 9, 5),
    );
    final meters = MemoryMeterRepository()..items[meter.id] = meter;
    final reminders = NoopMeterReminderRepository(initialMeterId: meter.id);

    await tester.pumpWidget(_testApp(meters: meters, reminders: reminders));
    await tester.pumpAndSettle();

    expect(find.text('Strom aus Erinnerung'), findsWidgets);
    expect(find.byType(BackButton), findsOneWidget);
    expect(await tester.binding.handlePopRoute(), isTrue);
    await tester.pumpAndSettle();
    expect(find.text('Strick & Häkelbuch'), findsOneWidget);

    await tester.tap(find.text('Strom aus Erinnerung'));
    await tester.pumpAndSettle();
    expect(find.byType(BackButton), findsOneWidget);
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.text('Strick & Häkelbuch'), findsOneWidget);
  });

  testWidgets('dashboard searches, sorts and shows last edited dates', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(430, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final meters = MemoryMeterRepository();
    final readings = MemoryReadingRepository();
    final alpha = _meter(
      id: 'alpha',
      label: 'Alpha Wasser',
      type: MeterType.knitting,
      location: 'Bad',
      updatedAt: DateTime.utc(2026, 9, 1, 8),
    );
    final beta = _meter(
      id: 'beta',
      label: 'Beta Strom',
      type: MeterType.knitting,
      location: 'Keller',
      updatedAt: DateTime.utc(2026, 8, 30, 8),
    );
    meters.items.addAll({alpha.id: alpha, beta.id: beta});
    readings.items['reading_beta'] = _reading(
      meter: beta,
      updatedAt: DateTime.utc(2026, 9, 2, 12),
    );

    await tester.pumpWidget(_testApp(meters: meters, readings: readings));
    await tester.pumpAndSettle();

    expect(find.text('Strick & Häkelbuch'), findsOneWidget);
    expect(find.text('Projekte suchen'), findsOneWidget);
    expect(find.text('Zuletzt bearbeitet'), findsOneWidget);
    expect(find.textContaining('Zuletzt bearbeitet:'), findsNWidgets(2));
    expect(
      tester.getTopLeft(find.text('Beta Strom')).dy,
      lessThan(tester.getTopLeft(find.text('Alpha Wasser')).dy),
    );

    await tester.enterText(
      find.widgetWithText(TextField, 'Projekte suchen'),
      'bad',
    );
    await tester.pumpAndSettle();
    expect(find.text('1 Treffer'), findsOneWidget);
    expect(find.text('Alpha Wasser'), findsOneWidget);
    expect(find.text('Beta Strom'), findsNothing);

    await tester.tap(find.byTooltip('Suche löschen'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Zuletzt bearbeitet'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Name A–Z'));
    await tester.pumpAndSettle();
    expect(
      tester.getTopLeft(find.text('Alpha Wasser')).dy,
      lessThan(tester.getTopLeft(find.text('Beta Strom')).dy),
    );
  });

  testWidgets('dashboard lazily renders and searches 500 meters', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(430, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final meters = MemoryMeterRepository();
    final readings = _CountingMemoryReadingRepository();
    for (var index = 0; index < 500; index++) {
      final id = 'large_$index';
      meters.items[id] = _meter(
        id: id,
        label: 'Projekt ${index.toString().padLeft(4, '0')}',
        type: MeterType.knitting,
        location: 'Test',
        updatedAt: DateTime.utc(2026, 9, 1),
      );
    }

    await tester.pumpWidget(_testApp(meters: meters, readings: readings));
    await tester.pumpAndSettle();

    expect(find.text('500 Projekte'), findsOneWidget);
    expect(readings.watchForMeterCalls, 0);
    final renderedCards = find.byWidgetPredicate(
      (widget) =>
          widget.key is ValueKey<String> &&
          (widget.key! as ValueKey<String>).value.startsWith(
            'dashboard-meter-',
          ),
    );
    expect(renderedCards.evaluate().length, lessThan(30));

    await tester.enterText(
      find.widgetWithText(TextField, 'Projekte suchen'),
      '0499',
    );
    await tester.pumpAndSettle();

    expect(find.text('1 Treffer'), findsOneWidget);
    expect(find.text('Projekt 0499'), findsOneWidget);
    expect(readings.watchForMeterCalls, 0);
  });

  testWidgets(
    'dashboard card acknowledges active reminder and keeps trigger time',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(430, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final meter =
          _meter(
            id: 'active_reminder',
            label: 'Gas Keller',
            type: MeterType.crochet,
            location: 'Keller',
            updatedAt: DateTime(2026, 9, 4),
          ).copyWith(
            reminder: const ReadingReminderSchedule(
              interval: ReminderInterval.daily,
              day: 1,
              hour: 6,
              minute: 0,
            ),
          );
      final meters = MemoryMeterRepository()..items[meter.id] = meter;
      final reminders = NoopMeterReminderRepository(
        statuses: {
          meter.id: ReminderStatus(
            meterId: meter.id,
            isNotificationActive: true,
            lastTriggeredAt: DateTime(2026, 9, 5, 6, 1),
          ),
        },
      );

      await tester.pumpWidget(_testApp(meters: meters, reminders: reminders));
      await tester.pumpAndSettle();

      expect(find.text('Erinnern: täglich um 06:00 Uhr'), findsOneWidget);
      final nextReminder = find.byKey(
        const ValueKey('next-reminder-active_reminder'),
      );
      expect(nextReminder, findsOneWidget);
      expect(
        find.descendant(
          of: nextReminder,
          matching: find.text('Nächste Erinnerung'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: nextReminder,
          matching: find.textContaining('06:00 Uhr'),
        ),
        findsOneWidget,
      );
      expect(
        find.text('Letzte Erinnerung: 05.09.2026, 06:01 Uhr'),
        findsOneWidget,
      );
      final badge = tester.widget<Badge>(find.byType(Badge));
      expect(badge.isLabelVisible, isTrue);
      expect(find.text('1'), findsOneWidget);

      await tester.tap(find.text('Gas Keller'));
      await tester.pumpAndSettle();
      expect(reminders.acknowledgedMeterIds, [meter.id]);

      expect(await tester.binding.handlePopRoute(), isTrue);
      await tester.pumpAndSettle();
      expect(tester.widget<Badge>(find.byType(Badge)).isLabelVisible, isFalse);
      expect(find.text('1'), findsNothing);
      expect(
        find.text('Letzte Erinnerung: 05.09.2026, 06:01 Uhr'),
        findsOneWidget,
      );
      expect(nextReminder, findsOneWidget);
    },
  );
}

class _CountingMemoryReadingRepository extends MemoryReadingRepository {
  int watchForMeterCalls = 0;

  @override
  Stream<List<MeterReading>> watchForMeter(String meterId) {
    watchForMeterCalls += 1;
    return super.watchForMeter(meterId);
  }
}

Widget _testApp({
  MemoryMeterRepository? meters,
  MemoryReadingRepository? readings,
  NoopMeterReminderRepository? reminders,
}) {
  return ProviderScope(
    overrides: [
      meterRepositoryProvider.overrideWithValue(
        meters ?? MemoryMeterRepository(),
      ),
      meterReadingRepositoryProvider.overrideWithValue(
        readings ?? MemoryReadingRepository(),
      ),
      evidenceExportRepositoryProvider.overrideWithValue(
        MemoryEvidenceExportRepository(),
      ),
      meterPhotoCaptureRepositoryProvider.overrideWithValue(
        const UnsupportedMeterPhotoCaptureRepository(),
      ),
      meterReminderRepositoryProvider.overrideWithValue(
        reminders ?? NoopMeterReminderRepository(),
      ),
    ],
    child: const MeterReadingLogApp(),
  );
}

Meter _meter({
  required String id,
  required String label,
  required MeterType type,
  required String location,
  required DateTime updatedAt,
}) {
  return Meter(
    id: id,
    label: label,
    type: type,
    unit: type == MeterType.knitting ? 'Runden' : 'Reihen',
    meterNumber: '${id}_number',
    location: location,
    createdAt: DateTime.utc(2026, 8, 1),
    updatedAt: updatedAt,
  );
}

MeterReading _reading({required Meter meter, required DateTime updatedAt}) {
  return MeterReading(
    id: 'reading_${meter.id}',
    meterId: meter.id,
    meter: MeterSnapshot.fromMeter(meter),
    value: ReadingValue.tryParse('123,4')!,
    capturedAt: DateTime.utc(2026, 9, 2, 10),
    timezoneOffsetMinutes: 120,
    storedAt: updatedAt,
    updatedAt: updatedAt,
    source: ReadingSource.camera,
    photoPath: '/tmp/photo.jpg',
    photoSha256: 'a' * 64,
    ocrRawText: '123,4',
    ocrCandidate: '123,4',
    manifestSha256: 'b' * 64,
  );
}

class _PendingReminderTestRepository extends NoopMeterReminderRepository {
  final Completer<ReminderTestResult> _test = Completer<ReminderTestResult>();

  @override
  Future<ReminderTestResult> showReminderTest(
    MeterReminderTestRequest request,
  ) {
    reminderTests.add(request);
    return _test.future;
  }

  void completeTest(ReminderTestResult result) => _test.complete(result);
}
