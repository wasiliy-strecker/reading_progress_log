# Startfehler nach teilweise abgeschlossenem Datenbankwechsel beheben

## Ursache und Reparatur

- Die letzten beiden vom Nutzer genannten Smartphone-Screenshots zeigten die
  ladende Projektübersicht und anschließend ausschließlich „Erneut laden“.
- Die Gerätedatenbank war laut `integrity_check` intakt, meldete aber weiterhin
  `user_version = 4`. Beide Schema-5-Spalten `photos_json` und
  `photo_change_json` waren bereits vorhanden. Die laufende App bestätigte den
  SQLite-Fehler `duplicate column name: photos_json`.
- Die Migration prüft jetzt vor dem Hinzufügen jeder neuen Fotospalte die
  tatsächliche Tabellenstruktur. Vorhandene Spalten und Inhalte bleiben
  unverändert. Fehlende Spalten werden ergänzt und der Wechsel auf Schema 5
  kann abgeschlossen werden. Kein Zurücksetzen und keine Datenlöschung nötig.
- Drei neue Regressionstests reproduzierten vor der Reparatur den Fehler für
  jede Kombination bereits vorhandener Fotospalten. Nach der Reparatur prüfen
  sie die Projektübersicht, Fotozuordnungen, Revisionen, Manifest-Prüfwerte und
  erneutes Öffnen der Datenbank.
- Die dokumentierte lokale Paritätsausnahme für die Migration wurde angepasst.
  Eingefrorene Quell-Hashes, Schema-Version und Generator-Eingaben bleiben
  unverändert. Keine Codegenerierung erforderlich.

## Prüfung und Gerät

- `dart format lib test`, `flutter analyze --no-pub` und `git diff --check`
  erfolgreich. Vollständige Suite mit `flutter test --no-pub --concurrency=2
  --timeout=2m --reporter expanded`: 471 Tests bestanden.
- Reparatur zunächst per Hot Restart auf dem eindeutig zugeordneten
  Android-Dev-Prozess geprüft. Danach war Schema 5 aktiv. Alle Zeilen der vier
  Anwendungstabellen waren gegenüber der vorab lokal gesicherten Datenbank
  unverändert. Originaldaten und Screenshots bleiben außerhalb des Repositories.
- Projektübersicht, vorhandenes Projekt, Projektstand samt Bild und
  Korrektureditor direkt am Smartphone geöffnet. Galerie-Hinzufügen war sichtbar.
  Den Editor anschließend ohne Änderungen verlassen.
- Zur dauerhaften Korrektur der zuvor installierten Dev-Version die APK neu
  gebaut. Paket `com.appfactory.strick_haekelbuch.dev`, Version `1.0.0+1`,
  Debug-Flag, fehlenden Installer und übereinstimmende Signatur geprüft.
  Datenerhaltendes Update mit `adb install -r -t -g --no-streaming` erfolgreich.
- Alle zehn vor der Installation geprüften App-Dateien danach per SHA-256
  unverändert. Installationszeit: 17.09.2026 um 20:39:33 Uhr.
- Anschließender Kaltstart öffnete die Projektübersicht ohne Fehleranzeige.
  Datenbankintegrität, Schema 5 und sämtliche ursprünglichen Tabellenzeilen
  erneut geprüft. Die aus der neuen APK geladene Migrationsquelle stimmt exakt
  mit dem Arbeitsstand überein. Installierte und gebaute APK sind identisch.
- APK-SHA-256: `1c4ef0ff27d8bb651f8f4761cfd85c6873d835fde1fc53c937df531c190ef582`.
  Das Artefakt bleibt außerhalb von Git. Keine Daten gelöscht.
