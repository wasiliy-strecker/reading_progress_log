# Fotos sortieren und PDF-Projektstände gliedern

- Fotos beim Erfassen und Korrigieren durch langes Drücken direkt im Raster
  verschieben. Hervorgehobene Ziele, automatisches Scrollen und alternativ
  „Nach vorne“ / „Nach hinten“ im Fotomenü. Import und Speichern sperren Sortierung.
- Reihenfolge im Entwurf sichern, bei Schreibfehlern zurücksetzen und erst beim
  Speichern übernehmen. Reine Umsortierungen behalten Foto-IDs und Dateien und
  erscheinen als „Fotoreihenfolge geändert“ im Korrekturverlauf.
- Neue Einzel- und Verlaufs-PDFs zeigen „Projektstand 1“ usw. und die Tabelle mit
  Reihe/Runde und Zeitpunkt vor dem ersten Foto. Überschrift, Tabelle und erstes
  Foto bleiben auf derselben Seite. Weitere Bilder tragen die Projektstandnummer.
  Nummern in der Verlaufsübersicht passen zu den Detailabschnitten.
- Bestehende PDFs, Datenbankschema, Backup-Version, Abhängigkeiten und eingefrorene
  Paritätsdateien bleiben unverändert. README und Verarbeitungsdokumentation ergänzt.

## Verifikation

- `dart format lib test`, `flutter analyze`, `git diff --check` erfolgreich.
- Vollständige Suite: 413 Tests erfolgreich. Zusätzlicher Backup-Lauf nach
  Bereinigung der Test-Fixture: 2 Tests erfolgreich.
- PDF-Audits mit `PDF_TEXT_AUDIT=true` unter UTC und Europe/Berlin: jeweils
  25 Tests erfolgreich. Textpositionen oberhalb des Bildes und die Zuordnung
  von Überschriften zu Fotoseiten werden geprüft. Layout zusätzlich gerendert.
- Tests decken Ziehen über Rasterzeilen, Abbruch, Rand-Scrollen, große Schrift,
  Menügrenzen, Sperrzustände, Entwurfswiederherstellung, Schreibfehler, Revisionen,
  Dateierhalt, Backup-Reihenfolge und PDF-Reihenfolge ab.
- Im ersten Gesamtlauf stürzte ein nativer Testprozess ab. Die Migrationstests
  bestanden separat und beim vollständigen Wiederholungslauf. Einen veralteten
  Textvergleich für die bereits eingeführten Mehrfoto-PDF-Hinweise angepasst.
- HONOR BVL N49 / Android 16: eigene Dev-VM anhand PID und Root-Library geprüft
  und per Hot Reload aktualisiert. Im separaten Testprojekt vier Bilder importiert,
  per Ziehen und Fotomenü umgeordnet, gespeichert und korrigiert. Korrekturbezeichnung
  und erzeugte PDF mit vier Fotos und dem richtigen ersten Bild kontrolliert.
  Testprojekt, Test-PDF und temporäres Galeriealbum anschließend entfernt.
- Kein APK-Build, keine Neuinstallation, kein Push. Die laufende Dev-Sitzung ist
  aktualisiert. Das dauerhaft installierte APK wird durch Hot Reload nicht ersetzt.
