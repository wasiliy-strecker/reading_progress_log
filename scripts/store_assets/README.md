# Deutsche Play-Store-Bilder erzeugen

Die Ausgabe vom 17.09.2026 liegt unter
`build/store-assets/de-DE/2026-09-17_2202/`. Sie enthält 18 Upload-Bilder,
`VORSCHAU.png`, `manifest.json`, eine Upload-Anleitung mit deutschen
Bildbeschreibungen und `strick-haekelbuch-play-store-bilder-de.zip`.
Generierte Bilder, APKs und Demo-Backups bleiben im ignorierten Build-Verzeichnis.

## Voraussetzungen und Aufnahmequelle

Alle Befehle vom App-Verzeichnis aus ausführen. Benötigt werden Flutter, Python 3,
Node 22 oder neuer, Google Chrome, ImageMagick, `rg`, `unzip` und das Android-SDK
mit Build Tools 36.0.0 sowie `system-images;android-35;google_apis;x86_64`.
Die vorhandenen Roboto-Schriften, das App-SVG und vier synthetische Projektfotos
werden unverändert als Eingaben verwendet. Keine zusätzlichen npm/Python-Pakete.

Quelle ist die tatsächliche Android-App im Dev-Profile-Build mit AOT-Dart-Code.
Dieser Build zeigt keine Dart-Debug-Bedienelemente. Androids Profile-Konfiguration
erbt dennoch das native Debug-Flag und die lokale Debug-Signatur.
Das ist eine Aufnahmequelle, kein Store-Release. Versionsnummer und Runtime-Code
werden für diese Bilder nicht geändert. APK-Hash, Paket, Version und Git-Quellstand
werden beim Vorbereiten protokolliert und beim Verpacken geprüft.

`prepare_emulator.sh` erstellt ausschließlich einen neuen, isolierten AVD.
`device.py` lehnt physische Geräte und fremde AVD-Namen ab. Jede Geräteaktion
benennt die Seriennummer ausdrücklich. Nur einen UI-Ablauf gleichzeitig ausführen.
Keinen bereits laufenden Nutzer-Emulator oder ein Smartphone übernehmen.

## Demo-Daten und Emulator

Der Host-Test erstellt ein regulär verschlüsseltes Backup mit drei erfundenen
Projekten und 24 Projektständen. 21 Stände haben keine Fotos. Der neueste Stand
des Wintersets hat zwei Fotos, Granny-Decke und Häkelkörbchen jeweils eines.
Der Test prüft den Import einschließlich Werte, Foto-Reihenfolge und Prüfsummen.
Es gibt keine OCR-Daten. `Demo2026` ist nur das öffentliche Testpasswort dieser
synthetischen Fixture und darf nicht für echte Nutzerdaten verwendet werden.

```bash
export SH_ASSET_DIR="$PWD/build/store-assets/de-DE/$(date +%Y-%m-%d_%H%M)"
flutter test --no-pub test/tooling/store_demo_backup_test.dart \
  --dart-define=STORE_DEMO_DIR="$SH_ASSET_DIR/raw/demo"
flutter build apk --profile --flavor dev --target-platform android-x64 --no-pub
bash scripts/store_assets/prepare_emulator.sh \
  build/app/outputs/flutter-apk/app-dev-profile.apk "$SH_ASSET_DIR"
```

Das letzte Kommando bleibt mit dem eigenen Emulator verbunden. SDK-Pfad und
ADB lassen sich über `SH_ANDROID_SDK` und `SH_ADB` einstellen. Ein anderer freier
gerader Emulator-Port wird mit `SH_EMULATOR_PORT` gewählt, standardmäßig 5580.
Bei den folgenden Befehlen die tatsächlich ausgegebene Seriennummer verwenden.

In einem zweiten Terminal denselben absoluten `SH_ASSET_DIR` setzen. Die
Initialisierung über den geprüften Geräte-Helper ausführen:

```python
import os
import sys
sys.path.insert(0, 'scripts/store_assets')
from device import Device

d = Device('emulator-5580')
package = 'com.appfactory.strick_haekelbuch.dev'
d.run('shell', 'wm', 'size', '1080x1920')
d.run('shell', 'wm', 'density', '360')
d.run('shell', 'settings', 'put', 'system', 'accelerometer_rotation', '0')
d.run('shell', 'settings', 'put', 'system', 'user_rotation', '0')
d.run('shell', 'cmd', 'uimode', 'night', 'no')
for setting in ['window_animation_scale', 'transition_animation_scale', 'animator_duration_scale']:
    d.run('shell', 'settings', 'put', 'global', setting, '0')
d.run('shell', 'cmd', 'locale', 'set-app-locales', package, '--user', '0', '--locales', 'de-DE')
d.run('shell', 'pm', 'grant', package, 'android.permission.POST_NOTIFICATIONS')
d.run('push', os.environ['SH_ASSET_DIR'] + '/raw/demo/Demo.shbackup', '/sdcard/Download/Demo.shbackup')
for source, name in [('01_stricken_schal.png', 'Schal.png'), ('02_stricken_muetze.png', 'Muetze.png')]:
    target = '/sdcard/Pictures/' + name
    d.run('push', 'assets/examples/project_photos/' + source, target)
    d.run('shell', 'am', 'broadcast', '-a', 'android.intent.action.MEDIA_SCANNER_SCAN_FILE', '-d', 'file://' + target)
d.run('shell', 'am', 'start', '-n', package + '/com.appfactory.strick_haekelbuch.MainActivity')
```

In der App Einstellungen → Backup wiederherstellen → Downloads → Demo.shbackup
wählen. Mit `Demo2026` und der regulären Wiederherstellung bestätigen.
Für die Statusleiste `python3 scripts/store_assets/device.py emulator-5580 status`
ausführen. Der Android-Demomodus zeigt 09:41 Uhr und verbirgt Benachrichtigungen.

## Smartphone-Motive

`device.py` bietet `dump`, `tap LABEL`, `capture DATEI` und `status` an.
`Device.run` erlaubt zusätzlich explizite Eingaben und echte Scroll-Gesten.
Screenshots erst nach Abschluss von Import, Bildverarbeitung und PDF-Erstellung
aufnehmen. Tastatur schließen und Erfolgshinweise abwarten.

| Rohbild unter `raw/phone/` | Echte App-Ansicht |
| --- | --- |
| `01.png` | Projektübersicht direkt nach Wiederherstellung mit allen drei Projekten |
| `02.png` | Winterset → Projektstand erfassen → Stand eintragen. Reihe 52 und Notiz „Am Schal weitergestrickt. Das Muster sitzt.“ |
| `03.png` | Derselbe ungespeicherte Entwurf nach gemeinsamer Auswahl von Schal und Mütze über „Fotos aus Galerie hinzufügen“ |
| `04.png` | Gespeicherten Stand 48 öffnen → Fotos sortieren. Erstes Foto über „Nach hinten“ verschieben und Menü von Foto 1 öffnen |
| `05.png` | Winterset → Alle Projektstände anzeigen. Liste mit 12 Ständen, neuester Stand 48 |
| `06.png` | Projekt & Erinnerung bearbeiten. Projekterinnerung aktiviert, täglich 09:00 Uhr, normale Erinnerung |
| `07.png` | Projektprotokoll für den Projektverlauf erstellen → Mit aktuellen Fotos. Vollständig gerenderte PDF-Vorschau |
| `08.png` | Einstellungen mit Datensicherung und Datenschutz |

Den Entwurf aus 02/03 verwerfen und anschließend auch die Erfassungsauswahl
verlassen. Die Fotokorrektur aus 04 regulär mit „Korrektur protokollieren“ speichern.
Dadurch bleiben es 24 Stände und der Wert 48 unverändert. Die Reihenfolge ist
anschließend Mütze, Schal. Motiv 05 wurde vor dieser Korrektur aufgenommen.
Die Erinnerung für 06 speichern und vor den Tablet-Übersichten wieder deaktivieren,
damit alle drei Projektkarten sichtbar sind. Das PDF zeigt die Stände absteigend
nummeriert, beginnend mit Projektstand 12. Die Folgeseiten enthalten ältere Stände
und die aktuellen Fotos.

## Tablet-Aufnahmen und Ausgabe

Jeweils auf der Projektübersicht starten. Die beiden Serien werden separat mit
echter Tablet-Geometrie aufgenommen. Eine kleine Scroll-Geste im Foto-Detail
macht den Reihenwert unter den zwei vollständigen Fotos sichtbar.

```bash
python3 scripts/store_assets/capture_tablet.py emulator-5580 7 "$SH_ASSET_DIR"
python3 scripts/store_assets/capture_tablet.py emulator-5580 10 "$SH_ASSET_DIR"
node scripts/store_assets/render.mjs assets "$SH_ASSET_DIR"
node scripts/store_assets/render.mjs contact "$SH_ASSET_DIR"
python3 scripts/store_assets/package.py "$SH_ASSET_DIR" \
  --apk build/app/outputs/flutter-apk/app-dev-profile.apk
```

| Upload-Gruppe | Anzahl | Pixel | Aufnahme-Dichte |
| --- | --- | --- | --- |
| App-Icon | 1 | 512 × 512 | SVG-Render |
| Feature-Grafik | 1 | 1024 × 500 | HTML-Layout |
| Smartphone | 8 | 1080 × 1920 | 360 dpi |
| 7-Zoll-Tablet | 4 | 1920 × 1080 | 240 dpi |
| 10-Zoll-Tablet | 4 | 2560 × 1440 | 288 dpi |

Die Smartphone-Layouts zeigen den vollständigen Screenshot proportional unter
einer Überschrift. Der Header nimmt weniger als 20 Prozent der Bildhöhe ein.
Es werden keine App-Bedienelemente retuschiert oder ergänzt. Tablet-Bilder sind
direkte Screenshots. ImageMagick setzt nur die verlustlose RGB/PNG-Kodierung.
Das Icon hat einen deckenden Hintergrund ohne aufgesetzte Außenmaske.

`package.py` prüft Bildanzahl, vollständige PNG-Dekodierung, Farbmodus, Maße,
Dateigröße und deutsche Alt-Texte mit höchstens 140 Zeichen. Das ZIP enthält
genau 21 Dateien. APK, Rohbilder, HTML-Dateien und Demo-Backup sind ausgeschlossen.
Alle Bilder zusätzlich visuell auf abgeschnittene Kernaussagen, Tastaturen,
Loader, Fehlermeldungen und fremde App-Namen prüfen.

Referenz: [Google Play – Preview assets](https://support.google.com/googleplay/android-developer/answer/9866151?hl=en-GB).

## Prüfungen und Abschluss

```bash
dart format lib test
flutter analyze --no-pub
flutter test --no-pub --dart-define=PDF_TEXT_AUDIT=true \
  test/tooling/store_demo_backup_test.dart \
  test/features/backup/multiple_photo_backup_test.dart \
  test/features/evidence/multiple_photo_pdf_test.dart \
  test/features/evidence/pdf_photo_grid_test.dart
python3 -m unittest discover -s scripts/store_assets -p 'test_*.py'
node --check scripts/store_assets/render.mjs
bash -n scripts/store_assets/prepare_emulator.sh
git diff --check
```

Den eigenen Emulator abschließend über `Device('emulator-5580').run('emu', 'kill')`
beenden. Erst nach dessen Ende ausschließlich den in
`raw/emulator-workspace.txt` aufgezeichneten temporären Aufnahme-AVD entfernen.
Die Ausgabedateien bleiben erhalten. Ein Store-Upload ist ein separater Auftrag.
