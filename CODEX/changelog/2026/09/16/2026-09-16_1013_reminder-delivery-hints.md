# Android-Erinnerungen verständlich absichern

- DND-Hinweis aus LeseLog app-lokal übernehmen und um App- und Kanalsperren
  ergänzen. Der wichtigste Zustand steht mit einem passenden Einstellungsbutton
  direkt vor dem Erinnerungstest. Fehler beim Öffnen bieten eine manuelle Anleitung.
- Status beim Öffnen, Moduswechsel, Zurückkehren, Fokuswechsel und Testen
  aktualisieren. Veraltete Antworten dürfen die aktuelle Anzeige nicht ersetzen.
  Keine zusätzliche DND-Berechtigung und keine automatische Änderung der
  Systemeinstellungen durch die App.
- Testbenachrichtigungen nach 60 statt 10 Sekunden entfernen. Den Blick in die
  Benachrichtigungsleiste erklären und nur die Übergabe an Android bestätigen.
  Erkannte Kanal- und App-Sperren melden. Native Kanalsperren liefern keinen
  vermeintlichen Testerfolg oder neuen regulären Auslösezeitpunkt.
- Projekte trotz Sperre speichern und die Einschränkung mit Einstellungszugang
  melden. Bei erneuter App-Freigabe gespeicherte Erinnerungen einmal abgleichen.
  Ungespeicherte Formulareingaben bleiben erhalten.

## Prüfung

- `dart format lib test` und `flutter analyze --no-pub` ohne Befunde.
- `flutter test --no-pub --concurrency=2`: alle 338 Tests bestanden. Enthalten
  sind Berechtigungs-/Kanalzustände, unbekannte und fehlgeschlagene Abfragen,
  veraltete Antworten, Einstellungsfehler, beide Themes und große Schrift,
  Speichern trotz Sperre sowie Wiederfreigabe ohne Verlust des offenen Entwurfs.
- Der erste parallele Lauf mit APK-Build erreichte bei zwei Backup-Tests das
  Zeitlimit. Nach Korrektur der neuen Testfälle bestand die vollständige Suite
  ohne Änderung der vorhandenen Timeouts mit geringerer Parallelität.
- `flutter build apk --debug --flavor dev --no-pub` erfolgreich. Paket
  `com.appfactory.strick_haekelbuch.dev`, Version 1.0.0+1, Dev-Label, Debug-Flag
  und identische SHA-256-Signatur gegenüber der installierten APK geprüft.
  Vorhandener Installer: keiner. Update mit `adb install -r -t -g --no-streaming`
  erfolgreich, anschließend kalt gestartet. Projektdaten blieben erhalten.
- HONOR BVL_N49 / Android 16: DND-Hinweis visuell geprüft. Native Testmeldung
  meldet `timeout=PT1M` und bei DND `mIntercept=true`. DND-Einstellungsbutton
  und Rückkehr funktionieren. Eine vorübergehend gesperrte normale Kategorie
  wird erkannt, der Test korrekt abgewiesen und der direkte Kategorie-Link
  geöffnet. Nach Wiederfreigabe verschwindet der Hinweis.
- Temporäre Gerätetests stellten den vorherigen Zustand wieder her:
  `zen_mode=0`, normale Erinnerungskategorie erlaubt. Keine Projektwerte geändert.
  Keine Versionsanhebung, keine Store-Installation und kein Upload.
