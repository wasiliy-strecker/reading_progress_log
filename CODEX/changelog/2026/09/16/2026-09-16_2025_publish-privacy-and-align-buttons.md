# Datenschutzerklärung auf GitHub und ausgerichtete Buttons

Die Einstellungen öffnen die Datenschutzerklärung wie LeseLog über
`url_launcher` in einer externen App. Das Ziel ist das vom Nutzer vorgegebene,
eigene Repository `wasiliy-strecker/reading_progress_log`. Die Erklärung folgt
der Struktur von LeseLog, beschreibt Projektfelder, manuelle Reihen/Runden,
Dokumentationsfotos und `.shbackup`-Dateien. Der externe GitHub-Aufruf und dessen
Datenverarbeitung sind ergänzt. Die bisherige Offline-Dialogansicht entfällt.

„Datenschutzerklärung öffnen“ zentriert auch mehrzeilige Beschriftungen.
„Erinnerung jetzt testen“ und „Alarme & Erinnerungen“ zeigen ihre Icons links
auf gleicher Höhe der horizontalen Achse und zentrieren die Texte im übrigen
Platz. Das Verhalten wurde anhand des Smartphone-Screenshots korrigiert.

## Prüfungen

- `dart format lib test` und `flutter analyze --no-pub` erfolgreich.
- 30 Tests in `settings_screen_test.dart` und `reminder_quiet_mode_test.dart`
  erfolgreich, einschließlich korrektem GitHub-Ziel, fehlgeschlagenem und
  fehlerwerfendem Browser-Aufruf, zentriertem Umbruch und Icon-Ausrichtung
  bei normaler und zweifacher Schriftgröße.
- `flutter build apk --debug --flavor dev --no-pub` erfolgreich. Der Build war
  wegen des zusätzlichen nativen URL-Launcher-Plugins erforderlich.
- Installierte und gebaute Identität `com.appfactory.strick_haekelbuch.dev`,
  Version `1.0.0+1`, Debug-Flag und übereinstimmende Signatur geprüft.
  Die bestehende Installation hatte keinen Store-Installer.
- Vor dem Update zeigte das Formular „Alles gespeichert“. Dev-APK mit
  `adb install -r -t -g --no-streaming` ohne Datenlöschung aktualisiert.
  Alle drei Buttons auf dem HONOR-Smartphone visuell geprüft.
- Git-Diff auf Whitespace und die bisherige Historie auf private Schlüssel,
  Token-Muster und sensible Dateitypen geprüft. LeseLog ist unverändert.

Commit und erstmaliger Push nach `origin/main` sind ausdrücklich beauftragt.
