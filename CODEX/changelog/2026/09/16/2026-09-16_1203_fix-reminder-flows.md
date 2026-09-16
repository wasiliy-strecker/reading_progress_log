# Erinnerungsabläufe korrigieren

- Beim Antippen einer Erinnerung die Zielkarte über dem aktuellen Bildschirm
  öffnen. Offene Formulare behalten ihre ungespeicherten Eingaben und sind über
  Zurück erreichbar. Wiederholtes Antippen stapelt dieselbe Zielkarte nicht erneut.
- Im Dashboard App- und Kategoriesperren je Erinnerungsart anzeigen. Der
  Einstellungszugang öffnet das passende Android-Ziel und erklärt bei einem
  Fehler den manuellen Weg. Nach Statusänderungen die Anzeige aktualisieren.
  Unbekannte und nicht unterstützte Zustände versprechen keine Zustellung.
- Den tatsächlich ausstehenden Android-Auslösezeitpunkt lokal mit dem Zeitplan
  speichern. Unveränderte Zeitpläne behalten auch einen fälligen, noch nicht
  zugestellten Termin bei App-Start, Geräte-/App-Neustart und Alarmfreigabe.
  Änderungen an Texten oder Zustellmodus überspringen ihn nicht. Veränderte
  Uhrzeiten/Intervalle sowie Systemzeit- oder Zeitzonenwechsel werden neu geplant.
  Nach der Verarbeitung die nächste Wiederholung setzen. Verspätete alte
  Broadcasts nach einer Neuplanung lösen keine zusätzliche Benachrichtigung aus.
- Dieselben Korrekturen und Regressionstests app-lokal in ZählerstandLog, LeseLog
  und Strick & Häkelbuch verwenden. Keine gemeinsame Runtime, neue Erinnerungsart,
  Versionsanhebung oder Änderung an Datenbank und Backup-Format.

## Prüfung

- `dart format lib test` und `flutter analyze --no-pub` erfolgreich.
- `flutter test --no-pub --concurrency=2 --timeout=2m --reporter expanded`:
  367 Tests bestanden.
- Zehn zusätzliche Flutter-Regressionstests prüfen erhaltene Eingaben bei
  bestehenden/neuen Einträgen, wiederholtes Antippen, beide Zustellmodi, App-
  und Kategoriesperren, passende Einstellungsziele, Entsperren, Fehlerpfad sowie
  unbekannte/nicht unterstützte Zustände.
- `./gradlew :app:compileDevDebugKotlin --console=plain` erfolgreich.
  `HourlyReminderCheck.java` und `ReminderScheduleUpdateCheck.java` gegen die
  tatsächlich kompilierten Kotlin-Klassen erfolgreich mit 16 und 40 Prüfungen.
- `flutter build apk --debug --flavor dev --no-pub` erfolgreich. Dabei die
  bereits installierte Engine über `FLUTTER_PREBUILT_ENGINE_VERSION` verwendet.
  Build-Grund ist die Änderung am nativen Android-Alarmplaner.
- APK-Paketkennung `com.appfactory.strick_haekelbuch.dev`, Debug-Flag und Version
  `1.0.0+1` geprüft. Korrigierte Codeabschnitte und neue Tests nach
  Normalisierung der App-Paketnamen in allen drei Apps identisch.
- `git diff --check` erfolgreich.

## Gerät

Kein Android-Gerät verbunden. Keine Installation, App-Datenänderung,
Store-Veröffentlichung oder Übernahme einer fremden Dev-Sitzung. Die neue
Dev-APK liegt unter `build/app/outputs/flutter-apk/app-dev-debug.apk`.
Ton, tatsächliche Android-Zustellung und Wiederplanung nach Geräteneustart
bleiben zusätzlich auf dem Gerät zu prüfen.

## Manueller Gerätetest

1. Formular mit ungespeicherten Eingaben öffnen. Eine Test-Erinnerung antippen
   und zurückgehen. Die Eingaben müssen erhalten bleiben.
2. App-Benachrichtigungen und danach nur eine Erinnerungskategorie sperren.
   Das Dashboard muss den passenden Hinweis und Einstellungsweg zeigen. Nach
   erneuter Freigabe muss wieder der nächste Termin sichtbar sein.
3. Eine normale Erinnerung einrichten. Bei noch ausstehender Zustellung nach
   Fälligkeit die App kalt öffnen. Der Termin darf nicht auf das nächste
   Intervall springen. Nach Zustellung muss die nächste Wiederholung folgen.
