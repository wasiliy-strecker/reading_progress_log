# PDF-Fotooption ohne aktuelle Fotos deaktivieren

- Gleiche Auswahllogik wie in ZählerstandLog, LeseLog und Pflanzenbuch:
  Fotooption sichtbar, deaktiviert und ohne Weiter-Pfeil, wenn keine aktuellen
  Fotos zugeordnet sind. Lesbarer Hinweis „Keine aktuellen Fotos vorhanden.“.
- Einzel-PDF prüft nur den gewählten Projektstand. Verlaufs-PDF prüft alle
  Einträge vor der Auswahl und verwendet dieselbe Liste für den Export.
  Mehrere aktuelle Fotos zählen, ausschließlich archivierte Fotos nicht.
- Auswahldialog für große Schrift scrollbar gemacht. Während der Vorbereitung
  und Auswahl weitere Exportaufrufe gesperrt. Abbruch und Ladefehler geben den
  Export wieder frei. Beim nächsten Öffnen werden die Zuordnungen neu geprüft.
- Fotozuordnung statt zusätzlicher Dateiprüfung verwendet. PDF-Erzeugung,
  Datenmodelle, Speicherung und bestehende Prüfwerte unverändert.

## Prüfung

- Formatierung und `git diff --check` ohne Befunde.
- `flutter analyze --no-pub` ohne Befunde. Ein anfänglicher Analyseabbruch am
  Systemlimit für geöffnete Dateien wurde durch einen separaten Lauf behoben.
- 18 neue Tests bestanden, einschließlich deaktivierter Auswahl, Einzel- und
  Gesamtverlauf, Foto außerhalb der Zehner-Vorschau, Abbruch, Wiederholung nach
  Ladefehler, mehrerer aktueller Fotos und ausschließlich archivierter Fotos.
- Dialogtests bei 360 × 640 und doppelter Schriftgröße in hellem und dunklem
  Design. Hinweistext erfüllt einen Kontrast von mindestens 4,5 zu 1.
- `flutter test --no-pub --concurrency=2`: 462 Tests bestanden.

Keine Smartphone-Bedienung, visuellen Gerätetests, APK-Builds, Installationen
oder Hot Reloads. Kein Push. Die installierte Dev-App bleibt unverändert.
