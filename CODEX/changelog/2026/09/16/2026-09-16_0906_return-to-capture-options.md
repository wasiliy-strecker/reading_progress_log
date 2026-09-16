# Zurück zur Auswahl der Projektstand-Erfassung

- Zurück-Pfeil und Android-Zurück führen aus der manuellen Eingabe und dem
  Fotoformular wieder zu „Stand eintragen“, „Projekt fotografieren“ und
  „Foto aus Galerie“. Erst ein weiteres Zurück verlässt die Erfassung.
- Ungespeicherte Eingaben behalten die Rückfrage zum Verwerfen. Bestätigtes
  Verwerfen setzt Zahl, Notiz und Zeitpunkt zurück und entfernt das temporäre
  Projektfoto. „Weiter bearbeiten“ erhält den Entwurf.
- Verifiziert: `dart format lib test`, `flutter analyze --no-pub` ohne Befunde;
  11 Tests in `manual_reading_screen_test.dart` und 29 Tests für Capture,
  Aktionslayout und App-Navigation bestanden.
- Am verbundenen Android-Gerät beide Zurück-Wege mit leerer manueller Eingabe
  geprüft. Dev-App nach Wiederverbinden per Hot Restart aktualisiert, da der
  erste Hot Reload der Attach-Sitzung den vorhandenen APK-Code nicht ersetzte.
  Kein APK-Build und keine Neuinstallation; Änderung gilt in der Live-Sitzung.
