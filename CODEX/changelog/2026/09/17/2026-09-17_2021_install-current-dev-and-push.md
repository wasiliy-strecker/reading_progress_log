# Aktuellen Dev-Stand dauerhaft installieren und veröffentlichen

- Auf Nutzerauftrag installierten Stand und Git-Remote geprüft. Die bisherige
  Dev-APK wurde am 17.09.2026 um 06:36 Uhr installiert und entsprach dem älteren
  Artefakt vor den Foto-Fehlerkorrekturen, Erfolgsmeldungen und PDF-Anpassungen.
- Aktuellen Code-Stand `c65eb74` mit `flutter build apk --debug --flavor dev
  --no-pub` gebaut. Version bleibt für diese Dev-Arbeit bei `1.0.0+1`.
- Vor dem Update Paket `com.appfactory.strick_haekelbuch.dev`, Debug-Flag,
  Version und fehlenden Installer geprüft. Die installierte und die neue APK
  besitzen dasselbe SHA-256-Signaturzertifikat.
- Keine aktiven Erfassungs-, Korrektur- oder Projektformulare und kein
  Backup-Passwortdialog in der eindeutig zugeordneten App-VM vorhanden.
- Installation mit `adb -s A5CS024205005243 install -r -t -g --no-streaming
  build/app/outputs/flutter-apk/app-dev-debug.apk` erfolgreich.
  Aktualisierungszeit auf dem Gerät: 17.09.2026 um 20:19:46 Uhr.
- Alle zehn vorab erfassten Dateien in `app_flutter`, `files` und `shared_prefs`
  unmittelbar nach dem Update vorhanden und per SHA-256 unverändert.
  Keine Deinstallation oder Datenlöschung ausgeführt.
- App anschließend neu gestartet. VM-PID und Root-Library geprüft. Alle sieben
  seit der früheren APK geänderten Laufzeitdateien stimmen exakt mit den aktuellen
  Quellen überein. Keine Flutter-Fehlermarker im Startprotokoll. Die installierte
  APK stimmt per SHA-256 mit dem neu gebauten Artefakt überein.
- `flutter analyze --no-pub` erfolgreich. Vollständige Suite mit
  `flutter test --no-pub --concurrency=2 --timeout=2m --reporter expanded`:
  468 Tests bestanden.
- Nutzerauftrag umfasst den Push. Nach `git fetch origin` liegen acht lokale
  Commits vor `origin/main`, ohne abweichende Remote-Commits. Ziel ist der
  bestehende Remote `git@github.com:wasiliy-strecker/reading_progress_log.git`,
  dessen Hauptzweig diese Strick-App enthält. Dieses Installationsprotokoll wird
  mit den bisher lokalen Änderungen gemeinsam übertragen.

## Artefakt

- `build/app/outputs/flutter-apk/app-dev-debug.apk` bleibt außerhalb von Git.
- SHA-256: `2f2036854581fa8f3a8cb91056e971746567e7251b8c8e3e837e23d400402057`.
- Das Update ist dauerhaft installiert und übersteht einen Kaltstart.
