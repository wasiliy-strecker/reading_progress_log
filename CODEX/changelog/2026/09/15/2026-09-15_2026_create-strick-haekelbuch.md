# Strick & Häkelbuch als eigenständige App

- LeseLog `49b242e5d9dfa32c776d9ade3d6a2f1cf2a7e491` als unabhängiges
  Flutter-Projekt übernommen; eigener Git-Verlauf und keine Nachbar-Abhängigkeit.
- Eigenständige Android Dev-/Store-, iOS- und Web-Identität, Version `1.0.0+1`,
  salbeigrüne/cremefarbene Gestaltung mit gut lesbarem Dunkelmodus und eigenem
  Wollknäuel-Icon aus einer app-lokalen SVG-Quelle.
- Projektname, Stricken/Häkeln, optionales Garn und Nadelstärke. Reihen/Runden
  unabhängig von der Technik pro Projekt wählbar. Ganze Zahlen ab 0 manuell
  erfassen; Fotoaufnahme und Fotokorrektur benötigen keine OCR mehr und
  verändern den manuell eingegebenen Stand nicht.
- Fotos, Notizen, Korrektur-/Fotohistorie, Verlauf/Suche, native Erinnerungen,
  Einzel-/Verlaufs-PDFs und verschlüsselte Backups übernommen. Eigene
  `.shbackup`-Kennung; fremde Backups werden auch nach Umbenennen abgelehnt.
- ML-Kit, Buchseiten-Demos und fremde GitHub-Verweise entfernt; Datenschutz
  offline zugänglich. Interne Speicherstruktur, Zahlendarstellung, Hashing,
  Verschlüsselung und Reparaturregeln beibehalten. Übernahme/Abweichungen und
  Referenz-Hashes in `docs/PROCESSING_PARITY.md` dokumentiert.

## Verifikation

- `flutter pub get`; Drift-Codegen wegen angepasster Datenbank-Quelldatei
  erfolgreich; generierte Tabellenstruktur bleibt bytegleich zur Vorlage.
- `dart format lib test`; `flutter analyze --no-pub`: keine Befunde.
- `flutter test --no-pub --concurrency=2`: **280 Tests bestanden**.
  Darunter Projektkombinationen, Rundenkorrekturen, unveränderter Zahlenwert bei
  Fotowechsel, Foto-Lebenszyklus, Datenbank, Backups/Fremdformat, PDF und Themes.
  Bei höherer paralleler Systemlast liefen zwei vorherige PDF-/Backup-Tests in
  das Zeitlimit; der vollständige Lauf mit zwei Testprozessen besteht ohne
  geänderte Zeitlimits oder reduzierte Assertions.
- PDF-Text-/Layoutaudits mit `PDF_TEXT_AUDIT=true` unter UTC und Europe/Berlin:
  jeweils **29 Tests bestanden**, einschließlich langer Notizen, aller Fotomodi
  und ursprünglicher Zeitzonen. Neuer PDF-Kopf enthält die eigene App-Identität.
- `flutter build apk --debug --flavor dev --no-pub`: erfolgreich. Erster Build
  erforderlich wegen eigener nativer Identität, Ressourcen und Erinnerungsicons.
- Native `HourlyReminderCheck.java` gegen gebaute Dev-Klassen: **16 Checks
  bestanden**, einschließlich Sommerzeitwechsel. Paket/Label/Version am APK
  geprüft: `com.appfactory.strick_haekelbuch.dev`, Strick & Häkelbuch Dev, 1.0.0 (1).
- Browser bei 412 × 915: Projekt mit Garn und Nadelstärke angelegt, Runden gewählt
  und Runde 32 manuell gespeichert; Hell-/Dunkelgestaltung visuell geprüft.
  Eigene Vorschau auf Port 53547; fremde Sitzungen auf 53545/53546 erhalten.
- LeseLog bleibt am ursprünglichen Commit mit sauberem Arbeitsbaum.

## Grenzen

Kein Android-Gerät verbunden: keine Installation, keine echte Kamera- oder
Benachrichtigungsprüfung am Telefon. Dev-APK liegt unter
`build/app/outputs/flutter-apk/app-dev-debug.apk` und kann datenbewahrend mit
`adb -s <device-id> install -r -t -g --no-streaming build/app/outputs/flutter-apk/app-dev-debug.apk`
installiert werden. Web bleibt wie LeseLog eine Vorschau mit flüchtigem Speicher;
Datei-/Backup- und Gerätefunktionen sind nativ. iOS auf Linux nicht gebaut.
Kein Store-Build, Upload oder Push; keine Signaturschlüssel übernommen.
