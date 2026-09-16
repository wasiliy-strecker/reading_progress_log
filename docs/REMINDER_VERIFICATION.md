# Erinnerungen prüfen

Die Apps verwenden dieselbe Prüfmatrix jeweils mit eigenen Tests und eigener
Android-Implementierung. Es gibt kein gemeinsames Laufzeitpaket.

## Automatische Prüfungen

| Ablauf | Nachweis |
| --- | --- |
| Fehler beim Planen, fehlende native Antwort, Statusabfrage gestört | `test/core/reminders/reminder_operation_result_test.dart` |
| Bereits gespeicherte Daten und unveränderte Erinnerung erneut speichern | `test/app/reminder_retry_test.dart` |
| Tatsächlich geplanter und überfälliger Termin, fehlende Alarmfreigabe, unbekannter Status | `test/app/reminder_planning_state_test.dart` |
| App-/Kategoriesperren und passende Android-Einstellungen | `test/app/reminder_flow_regression_test.dart` |
| Erinnerung antippen mit offenem Formular, Rückkehr und Kaltstart | `test/app/reminder_navigation_recovery_test.dart` |
| Löschen bei fehlgeschlagenem Ausschalten und erneuter Versuch | `test/features/meters/reminder_delete_failure_test.dart` |
| Wiederherstellung trotz einzelner Erinnerungsfehler | `test/features/backup/reminder_restore_failure_test.dart` |
| Android 7.0, 7.1 und 15. Ton, Vibration, Planung, verspätete Zustellung, Fehler und Wiederholung | `android/app/src/test/kotlin/com/appfactory/strick_haekelbuch/ReminderAndroidTest.kt` |
| Stundenintervalle, Sommerzeit und unveränderte ausstehende Termine | `test/native/HourlyReminderCheck.java`, `test/native/ReminderScheduleUpdateCheck.java` |

Aus dem App-Verzeichnis:

```bash
dart format lib test
flutter analyze
flutter test
```

Native Tests aus `android/`:

```bash
./gradlew :app:testDevDebugUnitTest
```

Die nativen Tests verwenden Robolectric. Die Android-Frameworks werden beim
ersten Lauf geladen. Die Gradle-Testabhängigkeiten werden nicht in das APK
aufgenommen. Hinweise auf veraltete Android-7-APIs in diesen Tests sind erwartet.

## Verbleibende Prüfung auf echter Hardware

Automatische Tests prüfen Programmabläufe und Android-Aufrufe. Herstellerseitige
Energiesparregeln, hörbare Lautstärke und physische Vibration benötigen ein Gerät.
Nur die Dev-Variante verwenden und vorhandene Eingaben vorher speichern.

1. Eine normale und eine pünktliche Test-Erinnerung auslösen. Kanal, hörbaren Ton
   und Vibration prüfen. Die Test-Erinnerung muss nach einer Minute verschwinden.
2. Eine geplante Erinnerung bei gesperrtem Gerät zustellen lassen. Danach müssen
   letzte Zustellung und nächster tatsächlicher Termin zusammenpassen.
3. App-Benachrichtigungen und die jeweilige Kategorie sperren und wieder erlauben.
   Hinweise und Einstellungswege prüfen. Ursprüngliche Geräteeinstellungen wiederherstellen.
4. „Alarme & Erinnerungen“ entziehen und wieder erlauben. Der Hinweis muss zur
   Freigabe führen. Nach der Rückkehr muss pünktlich neu geplant werden.
5. Gerät mit geplantem Termin neu starten. Ein noch ausstehender Termin darf
   nicht allein durch Öffnen der App übersprungen werden.
6. Erinnerung ausschalten beziehungsweise Testeintrag löschen. Danach darf für
   diesen Eintrag keine alte Erinnerung mehr erscheinen.

Der konkrete Teststand und ausgeführte Geräteprüfungen stehen im Changelog.
