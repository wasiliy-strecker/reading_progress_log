# Erinnerungen angleichen und Rückkehr nach Android-Neustart erhalten

- Navigations-Wiederherstellung für Flutter und GoRouter einschalten. Nach einer
  Prozessbeendigung durch entzogene Alarmfreigabe dieselbe Bearbeitungsseite mit
  der gespeicherten Datensatz-ID und funktionierendem Zurück-Weg öffnen.
  Neue Einträge behalten ihre Route, ohne einen Datensatz anzulegen. Keine
  zusätzliche Speicherung ungesicherter Eingaben einführen.
- Gemeinsamen app-lokalen Reminder-Vertrag für LeseLog, ZählerstandLog und
  Strick & Häkelbuch übernehmen. Verfügbarkeit unterscheidet App-Sperre,
  Kanal-Sperre, Freigabe sowie unbekannte und nicht unterstützte Zustände.
  Native Zustellung prüft auch gesperrte Kanalgruppen. Bei einer Sperre keinen
  neuen Auslösezeitpunkt vermerken. Bestehende Kanal- und Paketkennungen erhalten.
- Testergebnis ausdrücklich als Übergabe, App-Sperre, Kanal-Sperre, Fehler oder
  nicht unterstützt zurückgeben. Nur erfolgreiche Tests erklären die
  Benachrichtigungsleiste und die bestehende einminütige Anzeigedauer.
  Rückmeldung für erfolgreiche Tests acht Sekunden anzeigen.
- Nach erneut erteilter Benachrichtigungsfreigabe gespeicherte Zeitpläne erneut
  abgleichen. Offene Eingaben nicht als gespeicherte Daten übernehmen.
  Gleiche Verhaltensprüfungen in allen drei eigenständigen Apps verwenden.

## Prüfung

- Dart-Dateien formatiert. `flutter analyze --no-pub` ohne Befund.
- `flutter test --no-pub --concurrency=2 --timeout=2m`: 357 Tests bestanden.
- Neustarttests erzeugen einen neuen Router und prüfen erteilte, entzogene und
  unveränderte Alarmfreigabe, Datensatz-ID, aktuelle Warnung und Zurück-Navigation.
  Weitere Tests prüfen Wiederplanung, Zustellergebnisse und Systemeinstellungsziele.
- `./gradlew :app:compileDevDebugKotlin --console=plain` erfolgreich.
  Gemeinsamer Dart-Reminder-Vertrag und Wiederplanung nach Normalisierung der
  App-Kennungen identisch. Vorhandene native Kanal-IDs unverändert.
- `git diff --check` ohne Befund. Prüfung ausschließlich ohne Smartphone.
  Keine Geräteinstallation, Versionsanhebung oder Play-Veröffentlichung.
