# Mehrere Fotos pro Projektstand

- Kameraaufnahmen nacheinander und Galerie-Mehrfachauswahl lassen sich in einem
  Projektstand kombinieren. Gemeinsame Fotoübersicht mit Vollbild, Wischen und Zoom.
- Fotos einzeln ergänzen, ersetzen und entfernen. Ersetzen erhält die Position.
  Gespeicherte alte Bilder bleiben mit stabilen IDs im Korrekturverlauf sichtbar.
  Abbrechen entfernt nur neue, ungespeicherte Dateien. Projektstand und Zeitpunkt
  bleiben bei Fotokorrekturen erhalten.
- Vor externen Kamera-/Galerieaufrufen wird ein interner Entwurf mit Formular,
  Zielroute und Fotoaktion gesichert. Wiederherstellung übernimmt alle verlorenen
  Picker-Ergebnisse. Bereits abgeschlossene Entwürfe beschädigen keine gespeicherten
  Dateien, auch wenn die Bereinigung des Entwurfs fehlgeschlagen ist.
- Datenbankschema 5 liest alte Einzelfotos ohne Änderung ihrer bisherigen
  Manifestdarstellung. Backup-Version 4 sichert aktuelle und historische Bilder.
  Versionen 1–3 bleiben lesbar. Eine synthetische Version-3-Fixture prüft den
  bisherigen Codec einschließlich seiner authentifizierten Daten.
- Neue Einzel- und Verlaufs-PDFs enthalten alle aktuellen Fotos. Ersetzte und
  entfernte Bilder werden nicht neu eingebettet. Gespeicherte PDFs bleiben
  unveränderte Dokumente. Kompakte PDFs bleiben ohne Bilder.
- Dokumentation und begründete Paritätsausnahmen aktualisiert. Der eingefrorene
  Referenzvergleich und LeseLog bleiben unverändert.

## Verifikation

- Drift-Codegenerierung nach Schemaänderung ausgeführt.
- `dart format lib test` und `flutter analyze` erfolgreich, keine Befunde.
- Vollständige Suite: `flutter test --reporter expanded`, 407 Tests erfolgreich.
- Nach der letzten Anpassung der PDF-Hinweistexte: 42 gezielte UI-/Paritätstests
  und erneute Analyse erfolgreich.
- PDF-Text- und Layoutaudits mit `PDF_TEXT_AUDIT=true` unter `TZ=UTC` und
  `TZ=Europe/Berlin`, jeweils 25 Tests erfolgreich.
- HONOR BVL N49, Android 16: richtige Dev-VM anhand PID und Root-Library geprüft,
  vorhandene Sitzung angehängt und wegen Initialisierungsänderungen per Hot Restart
  aktualisiert. Abschließende Textkorrektur per Hot Reload. Kein APK-Build.
- Am Gerät drei Galeriebilder gemeinsam und zwei Kameraaufnahmen nacheinander
  hinzugefügt. Vollbildwechsel geprüft. Ein Foto ersetzt und eines entfernt,
  Korrektur gespeichert. Vier aktuelle und fünf vorherige Fotos korrekt angezeigt.
  Die erzeugte Geräte-PDF enthält nachweislich vier Bilder mit fortlaufenden
  Beschriftungen. Testprojekt, Test-PDF und temporäres Testalbum wieder entfernt.
- Android-Prozesswiederherstellung, Dateibereinigung, Migrationen, Backup-Reparatur
  und unveränderte gespeicherte PDFs automatisiert geprüft. Ein echter Android-
  Prozessabbruch während des Pickers wurde in der Live-Sitzung nicht durchgeführt.
- `git diff --check` erfolgreich. Lokaler Commit, kein Push.

Die laufende Dev-Sitzung enthält die Änderung. Hot Reload/Restart aktualisiert
nicht das dauerhaft installierte APK.
