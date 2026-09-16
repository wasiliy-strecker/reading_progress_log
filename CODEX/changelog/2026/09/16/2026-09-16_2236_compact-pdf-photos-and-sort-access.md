# Kompakte PDF-Fotos und sichtbarer Zugang zur Sortierung

## Änderungen

- Neue Einzel- und Verlaufs-PDFs zeigen zwei aktuelle Fotos pro Zeile. Das letzte
  unpaarige Foto steht zentriert mit derselben Feldgröße, auch bei nur einem Foto.
  Seitenverhältnis und vollständiger Bildinhalt bleiben erhalten.
- Projektstandnummer, Reihe/Runde und Zeitpunkt bleiben über der ersten Fotozeile.
  Weitere Zeilen tragen den Projektstand als Kontext. Bildpaare bleiben auf einer
  Seite. Fehlende Fotos behalten einen beschrifteten Platz.
- Die Detailansicht zeigt bei mehreren aktuellen Fotos „Fotos sortieren“ direkt
  oberhalb der Galerie. Der zuletzt bereitgestellte Screenshot zeigte diese
  bisher nur lesbare Ansicht. Der neue Zugang öffnet den vorhandenen Editor mit
  Ziehen und Fotomenü. Erst „Korrektur protokollieren“ speichert die Reihenfolge.
- README und Verarbeitungsdokumentation beschreiben das Verhalten. Bestehende
  gespeicherte PDFs werden nicht verändert. Schema, Backup-Format und eingefrorene
  Paritätsdateien bleiben unverändert.

## Prüfung

- `dart format lib test` und `flutter analyze` erfolgreich.
- Gesamte Flutter-Suite: 430 Tests erfolgreich.
- PDF-Audits mit `PDF_TEXT_AUDIT=true` in UTC und Europe/Berlin erfolgreich.
  Der UTC-Lauf enthält 81 PDF-Tests und zwei zusätzliche Sortierzugangstests,
  der Berlin-Lauf 81 PDF-Tests.
- Neue PDF-Tests prüfen 0, 1, 2, 3, 4, 5 und 12 Fotos für Einzel- und
  Verlaufsberichte, Zentrierung, Bildproportionen, Beschriftung und Seitenumbrüche.
  Drei Fotos mit kurzem Projektkopf passen in einem Einzelbericht auf eine Seite.
- Widget-Tests prüfen den Einstieg aus der Detailansicht, das Speichern einer
  neuen Reihenfolge und die unveränderten Werte und Zeitangaben.
- `git diff --check` erfolgreich.
- Die bestehende Dev-Sitzung wurde nach Prüfung von VM-PID und Root-Library per
  Hot Reload aktualisiert. Kein APK gebaut oder installiert. Die Aktualisierung
  gilt für die laufende Sitzung und ersetzt nicht die dauerhaft installierte APK.
- Auf ausdrücklichen Wunsch keine weiteren visuellen Gerätetests, da der Nutzer
  abwesend und das Smartphone gesperrt ist.
