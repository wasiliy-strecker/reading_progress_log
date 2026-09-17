# Mehrere Fotos beim Korrigieren gezielt nachprüfen

- Den aktuellen Korrektureditor, die Mehrfachauswahl und den Speicherweg
  geprüft. Dieser Ablauf war bereits in `a04fc97` enthalten. Die danach
  hinzugekommene Änderung `f96f261` betrifft die Fotooption beim PDF-Export.
- Sechs gezielte Regressionstests über den tatsächlichen Korrekturbildschirm
  und die SQLite-Repositories ergänzt. Der kontrollierte Galerie-Picker liefert
  zuerst drei und anschließend zwei zusätzliche Fotos.
- Für Einträge ohne Foto, mit einem alten Einzelfoto, mit mehreren aktuellen
  Fotos und mit ausschließlich historischen Fotos bestätigt: Alle Ergänzungen
  bleiben nach Speichern und erneutem Öffnen in der richtigen Reihenfolge
  vorhanden. Vorhandene Foto-IDs, Projektstand, Zeitpunkt, Zeitzonenoffset,
  Notiz und Fotoarchiv bleiben erhalten. Der Korrekturverlauf enthält genau
  eine passende Vorher-/Nachher-Liste und der Manifest-Prüfwert stimmt.
- Ein fehlgeschlagener Datenbankschreibversuch hält sämtliche neuen Fotos für
  den erneuten Versuch bereit. Die Wiederholung erzeugt keine doppelten Fotos
  oder Revisionen. Abbrechen der Galerieauswahl erhält bisherige Ergänzungen.
  Verwerfen der Korrektur entfernt ausschließlich deren neue temporäre Fotos.
- Kein neuer Funktionsfehler festgestellt. Änderungen nur an Tests und diesem
  Changelog, keine Änderung am Laufzeitcode erforderlich.

## Prüfung

- `dart format lib test`, `flutter analyze --no-pub` und `git diff --check`
  erfolgreich.
- 37 gezielte Tests bestanden: `correction_photo_additions_test.dart`,
  `multiple_photo_workflow_test.dart`, `reading_photo_session_test.dart`,
  `multiple_photos_test.dart` und `meter_photo_store_test.dart`.
- Smartphone laut Nutzer nicht angeschlossen. Keine Geräteaktionen,
  Installation oder APK-Erstellung. Native Galerie- und Kameradialoge wurden
  in dieser Aufgabe nicht am Gerät geprüft.
