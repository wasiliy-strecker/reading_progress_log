# Eigenen Quellcode in den Einstellungen öffnen

Den bisherigen Lizenzhinweis um den anklickbaren Eintrag „Quellcode auf GitHub“ mit Browser-Symbol ergänzt. Das Ziel ist das eigene Repository `wasiliy-strecker/reading_progress_log`. Der Untertitel „Open Source · MPL 2.0“ bleibt erhalten. Titel und Fehlerhinweis sind in allen sechs Sprachen vorhanden. Datenschutz- und Quellcode-Link verwenden dieselbe abgesicherte Browseröffnung.

Prüfung: `flutter gen-l10n`, `dart format lib test`, `flutter analyze --no-pub` und `python3 scripts/check_localizations.py` erfolgreich. Alle 37 Tests aus `test/features/backup/settings_screen_test.dart`, `test/core/localization_test.dart` und `test/app/localization_ui_test.dart` erfolgreich. Die Tests prüfen das exakte Linkziel, Rückgabewert false und Ausnahme beim Öffnen sowie die Anzeige in sechs Sprachen auf schmalen Bildschirmen mit normaler und vergrößerter Schrift.

Auf Nutzerwunsch ausschließlich Quellcode, Übersetzungen und Tests angepasst. Kein App-Build, keine Installation, keine Versionsänderung und kein Push.
