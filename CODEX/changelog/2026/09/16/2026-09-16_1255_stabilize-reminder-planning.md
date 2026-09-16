# Bestehende Erinnerungen stabilisieren

## Korrekturen

- Android bestätigt Planung und Ausschalten ausdrücklich. Fehler bleiben sichtbar
  und können ohne Änderungen am Formular erneut gespeichert werden. Bereits
  gespeicherte Fachdaten werden nicht als fehlgeschlagene Speicherung behandelt.
- Die Übersicht zeigt den tatsächlich angenommenen Android-Termin. Ein noch
  ausstehender Termin bleibt sichtbar. Fehlende Planung, verweigerte pünktliche
  Alarmfreigabe und ungenaue Ersatzplanung führen zum passenden Prüfweg.
- Beim Löschen zuerst die Erinnerung ausschalten. Bei Fehlern bleiben die Daten
  erhalten. Die Wiederherstellung verarbeitet die übrigen Erinnerungen weiter
  und meldet einzelne Probleme getrennt vom erfolgreichen Datenimport.
- Fehlgeschlagene Zustellung unterbricht die nächste Wiederholung nicht. Alte
  Broadcasts nach abgebrochener Planung oder Ausschalten erzeugen keine neue Meldung.
- Auf Android 7.0 und 7.1 Ton und Vibration auch ohne Benachrichtigungskanäle
  setzen. Test-Erinnerungen verschwinden auch dort nach einer Minute.
- Dieselben Korrekturen app-lokal in allen drei Apps. Keine neue Erinnerungsart,
  gemeinsame Runtime, Änderung des Datenbank-/Backupformats oder Versionsanhebung.

## Prüfung

- `dart format lib test`, `flutter analyze` und `git diff --check` erfolgreich.
- `flutter test --no-pub --concurrency=2 --timeout=2m --reporter expanded`:
  **381 Tests bestanden.**
- Je App 14 zusätzliche Flutter-Testfälle für tatsächliche Planung, Berechtigungen,
  fehlgeschlagene Operationen, erneutes Speichern, Wiederherstellung und Löschen.
  Bestehende Kontrast- und Dashboard-Fixtures enthalten nun bestätigte Zeitpläne.
- `./gradlew :app:testDevDebugUnitTest --no-daemon --max-workers=2`:
  **25 Tests bestanden**, Android-APIs 24, 25 und 35. Einschließlich simulierter
  Planungs-, Ausschalt- und Zustellfehler sowie wieder erteilter Alarmfreigabe.
- Die bestehenden nativen `HourlyReminderCheck.java` und
  `ReminderScheduleUpdateCheck.java` gegen die kompilierten Kotlin-Klassen:
  16 und 40 Prüfungen bestanden.
- Der vorherige Gesamtlauf mit 30-Sekunden-Limit hatte Zeitüberschreitungen in
  bestehenden PDF-/Backup-Tests bei hoher Festplattenlast. Erneuter Gesamtlauf
  ohne parallele Android-Tests mit Zwei-Minuten-Limit erfolgreich. Kein
  Anwendungscode und keine Testbehauptung zur Umgehung dieser Timeouts geändert.
- Gemeinsame Prüfmatrix: [Erinnerungen prüfen](../../../../../docs/REMINDER_VERIFICATION.md).

## Dev-Gerät

- Neuer Dev-APK-Build erforderlich wegen Änderungen am nativen Alarmplaner und
  an Benachrichtigungen. Gebaut mit `flutter build apk --debug --flavor dev --no-pub`
  und der lokal vorhandenen Engine über `FLUTTER_PREBUILT_ENGINE_VERSION`.
- Installierte Paketkennung `com.appfactory.strick_haekelbuch.dev`, Version `1.0.0+1`,
  Debug-Flag, Installer und passende APK-Zertifikate geprüft.
- Auf dem verbundenen Honor datenbewahrend mit
  `adb install -r -t -g --no-streaming build/app/outputs/flutter-apk/app-dev-debug.apk`
  aktualisiert und gestartet. Der Nutzer hat offene LeseLog-Eingaben zuvor
  als gespeichert bestätigt.
- Zusätzlich auf dem Honor über den echten Flutter-Android-Kanal normale und
  pünktliche Planung bestätigt, beide Testmeldungen an Android übergeben und
  die synthetische Erinnerung anschließend erfolgreich ausgeschaltet. VM-PID
  und App-Bibliothek vor dem Test geprüft. Keine Fachdaten angelegt.
  Bei vorhandener Alarmfreigabe meldete nur der pünktliche Modus einen
  exakten Alarm. Keine Geräteeinstellung verändert.
- Hörbarer Ton, physische Vibration und reale Zustellung nach längerem Standby
  oder Geräteneustart bleiben nach der dokumentierten Matrix am Gerät zu prüfen.
- Keine Store-Installation ersetzt, keine App-Daten gelöscht und nichts veröffentlicht.
