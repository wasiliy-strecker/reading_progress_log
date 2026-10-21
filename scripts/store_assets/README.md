# Internationale Play-Unterlagen lokal erzeugen

Sechs Sprachpakete: de-DE, en-US, es-ES, fr-FR, it-IT und pt-BR.
Jedes enthält ein Icon, eine Feature-Grafik, sechs Smartphone-Bilder und je vier
Bilder für 7- und 10-Zoll-Tablets. Insgesamt 96 Upload-Bilder. Englisch ist der
vorbereitete Standard des Store-Eintrags. Keine Länderfreigabe wird geändert.

## Aufnahmequelle und Daten

Voraussetzungen: Flutter, Android SDK mit API-35-Google-APIs-x86_64-Systemimage,
Build Tools 36.0.0, Python 3, Node 22, Chrome und ImageMagick. Bestehendes Marken-SVG,
Roboto-Schriften und vier synthetische Projektfotos verwenden. Keine neuen
Bildgeneratoren oder zusätzlichen Python-/npm-Pakete erforderlich.

Quelle ist die wirkliche App als Dev-Profile-APK mit AOT-Code. Es enthält keine
Dart-Debug-Bedienelemente. Androids Profile-Konfiguration erbt die lokale
Debug-Signatur. Das ist kein Store-Build. Diese Aufnahme-APK niemals auf das
Nutzer-Smartphone installieren. Ein Dev-Debug-APK für das Smartphone ist ein
separater Vorgang nach den Regeln in AGENTS.md.

`prepare_emulator.sh` erzeugt für jede Sprache einen frischen isolierten AVD.
`Device` akzeptiert nur explizite Emulator-Seriennummern und eigene AVD-Namen mit
Präfix `sh_store_assets`. Fremde Emulatoren und physische Geräte werden abgewiesen.
Keine Aufnahmeschritte auf einem impliziten ADB-Ziel ausführen.

`locales/<Locale>.json` enthält übersetzte erfundene Projekte, Notizen und
Bildüberschriften. Drei Projekte besitzen insgesamt 24 manuelle Stände und vier
synthetische Fotos. Das Testpasswort `Demo2026` ist öffentlich und nur für diese
Fixture geeignet. Der Host-Test erzeugt regulär verschlüsselte Backups und prüft
Wiederherstellung, Werte, Foto-Reihenfolge und Prüfsummen. Keine OCR-Daten.

```bash
flutter test --no-pub --timeout 3m test/tooling/store_demo_backup_test.dart \
  --dart-define=STORE_DEMO_LOCALE=all \
  --dart-define=STORE_DEMO_DIR=build/international-work/demo
flutter build apk --profile --flavor dev --target-platform android-x64 --no-pub
```

## Je Sprache aufnehmen

Einen freien geraden Port verwenden. Niemals eine bereits laufende Instanz
übernehmen. `prepare_emulator.sh` bleibt bis zum Ende seines Emulators geöffnet.
Quell-APK, Version, Git-Basisstand, Status und Quellbaum-Fingerabdruck werden
protokolliert. SDK und ADB können mit `SH_ANDROID_SDK` und `SH_ADB` gesetzt werden.

```bash
SH_EMULATOR_PORT=5610 bash scripts/store_assets/prepare_emulator.sh \
  build/app/outputs/flutter-apk/app-dev-profile.apk \
  build/international-work/capture/de-DE
python3 scripts/store_assets/capture_international.py emulator-5610 de-DE \
  releases/international/build-1/store/de-DE
node scripts/store_assets/render.mjs assets \
  releases/international/build-1/store/de-DE de-DE
node scripts/store_assets/render.mjs contact \
  releases/international/build-1/store/de-DE de-DE
```

Die Aufnahme setzt nur im eigenen Emulator die Gerätesprache und -region, startet
Android dort neu und importiert das jeweilige Backup über die normale App.
Androids Demomodus setzt die Statusleiste auf 09:41. PDF-Erstellung erfolgt in der
App. Nicht gespeicherte Demonstrationsformulare werden nur auf diesem synthetischen
Testgerät verlassen. Es gibt keinen versteckten Demo-Modus im Runtime-Code.

Auf belasteten Rechnern zunächst nur zwei Emulatoren gleichzeitig verwenden.
Die Automatisierung wartet auf die Android-Dienste und frische Accessibility-Bäume.
Ein erkannter Startstillstand von Androids System UI kann mit Warten fortgesetzt
werden. App-eigene Fehler werden dadurch nicht ausgeblendet. Nach einem Abbruch
den tatsächlichen Bildschirm prüfen. `--phase restore` setzt im Dateiauswahldialog
fort. `--phase capture` nimmt ein bereits importiertes Beispiel erneut auf.
`--from-screen 4` beginnt bei den Erinnerungen. Diese Wiederholungen nur für eine
noch nicht fertig übergebene Lieferung verwenden.

Smartphone-Motive: Übersicht, Bearbeiten eines Standes mit Fotos, Verlauf,
Erinnerungseinstellungen, erzeugtes PDF und Einstellungen mit Sprachwahl/Backup.
Tablet-Motive: Übersicht, Verlauf, Fotodetail und Einstellungen.

| Gruppe | Anzahl je Sprache | Pixel | Dichte |
| --- | --- | --- | --- |
| Icon | 1 | 512 × 512 | SVG-Render |
| Feature-Grafik | 1 | 1024 × 500 | HTML-Layout |
| Smartphone | 6 | 1080 × 1920 | 360 dpi |
| 7-Zoll-Tablet | 4 | 1920 × 1200 | 320 dpi |
| 10-Zoll-Tablet | 4 | 2560 × 1600 | 300 dpi |

Die Smartphone-Bilder zeigen die proportional skalierte App-Fläche unter
übersetzten Überschriften. Nur die Android-Status- und Navigationsleisten werden
im Rahmen ausgeblendet. Oben entfallen 72 Pixel mit Statussymbolen und Leerraum,
unten 54 Pixel der Navigationsleiste bei 360 dpi. Die Rohaufnahmen bleiben
unverändert. Keine App-Bedienelemente ergänzen oder retuschieren.
Tablet-Bilder sind direkte Aufnahmen in echter Tablet-Geometrie. Die PNG-Konversion
ändert nur die verlustlose RGB-Kodierung. Icon: deckendes PNG32. Andere Bilder:
PNG24 ohne Alpha. `VORSCHAU.png` ist eine Kontaktübersicht und kein Upload-Bild.

## Prüfen und verpacken

Die kopierbaren Texte in `store-listings/<Locale>/` pflegen. Titel höchstens 30,
Kurzbeschreibung 80, vollständige Beschreibung 4000 Zeichen. Release-Notizen
höchstens 500 Zeichen. Keine führenden Markdown-Aufzählungen in Textfeldern.

```bash
python3 scripts/store_assets/package_international.py \
  releases/international/build-1 \
  --captures build/international-work/capture \
  --apk build/app/outputs/flutter-apk/app-dev-profile.apk
python3 -m unittest discover -s scripts/store_assets -p 'test_*.py'
node --check scripts/store_assets/render.mjs
bash -n scripts/store_assets/prepare_emulator.sh
```

Das gemeinsame ZIP enthält nur Store-Unterlagen und Vorschauen. APKs, Rohbilder,
Demo-Backups und temporäre HTML-Dateien gehören nicht in das Store-ZIP. Nach der
Verpackung alle sechs Kontaktübersichten und relevante Einzelbilder visuell prüfen.
Lesbarkeit, echte Zielsprache, keine abgeschnittenen Texte, leere Bilder, Lade-
oder Fehlermeldungen prüfen. Technische Prüfungen ersetzen keine muttersprachliche
Abnahme. Tatsächlichen Umfang in der Lieferung dokumentieren.

Offizielle Vorgaben, am 21.10.2026 geprüft:
[Grafiken und Screenshots](https://support.google.com/googleplay/android-developer/answer/9866151?hl=en-GB)
und [Store-Eintrag](https://support.google.com/googleplay/android-developer/answer/9859152?hl=en).
Die Grenzen vor einer späteren Lieferung erneut prüfen.

## Eigene Arbeitsumgebung entfernen

Nur den eigenen Emulator über `Device(serial).run('emu', 'kill')` beenden. Danach
nur das in `raw/emulator-workspace.txt` protokollierte `sh-store-assets-*`-Verzeichnis
entfernen. Vor der nächsten Sprache einen neuen AVD erstellen. Gemeinsame SDKs,
Schlüssel, fremde AVDs und andere Apps bleiben erhalten. Nach erfolgreicher Übergabe
eigene Demo-Backups und Layout-Arbeitsdateien entfernen. Lieferungen dauerhaft im
Git-ignorierten `releases/international/build-<Code>/` erhalten. Nicht hochladen.
