# Strick & Häkelbuch

Eine eigenständige Flutter-App für Strick- und Häkelprojekte. Merke dir, bei
welcher Reihe oder Runde du aufgehört hast, und dokumentiere dein Projekt mit
Fotos und Notizen. Android-first, lokal und ohne Konto.

## Funktionen

- Projekte mit Name, Technik **Stricken/Häkeln**, optionalem Garn und Nadelstärke
- Zählweise **Reihen/Runden** pro Projekt, unabhängig von der Technik
- Manuelle Eingabe der aktuellen Reihe oder Runde als ganze Zahl ab 0
- Projektstand mit oder ohne Fotos. Mehrere Kameraaufnahmen nacheinander oder
  Galerie-Mehrfachauswahl, auch gemischt
- Datum/Uhrzeit, Notizen, Verlauf mit Suche, Fortschrittsdifferenzen und Korrekturen
- Fotoübersicht mit Großansicht, Wischen und Vergrößern
- Einzelne Fotos nachträglich ergänzen, ersetzen oder entfernen, mit erhaltener
  Fotohistorie und Vorher-/Nachher-Ansicht
- Optionale stündliche, tägliche, wöchentliche, monatliche und jährliche Erinnerungen
- Projektprotokolle als Einzel- und Verlaufs-PDF, mit allen aktuellen Fotos oder
  kompakt ohne Fotos. Bereits gespeicherte PDFs bleiben unverändert
- Passwortgeschützte AES-256-GCM-Backups (`.shbackup`) einschließlich Fotos,
  Korrekturverläufen und gespeicherten PDFs

Es gibt keine automatische Erkennung von Reihen oder Runden. Ein neues Foto
verändert die eingegebene Zahl nicht. Neue Projekte starten mit Stricken/Reihen;
beide Angaben lassen sich unabhängig ändern. Garn und Nadelstärke sind Freitext,
beispielsweise „Merinowolle, Salbei“ und „4,5 mm“.

Bei Änderungen der Projektangaben bleiben historische Angaben je Projektstand
erhalten. Fortschrittsdifferenzen werden nur zwischen gleichen Einheiten
berechnet. Niedrigere Stände sind möglich, etwa nach dem Auftrennen.

## Übernommenes Verhalten

Grundlage ist LeseLog `49b242e5d9dfa32c776d9ade3d6a2f1cf2a7e491`, einschließlich
der jüngsten Formular-, Foto-, Backup- und PDF-Verbesserungen. LeseLog wurde
nicht verändert. Architektur: Feature-first Clean MVVM, Riverpod, Drift/SQLite
und austauschbare Foto-, Reminder-, Export- und Backup-Implementierungen.
Keine Runtime-Abhängigkeit auf eine andere App.

Fotos lassen sich beim Erfassen und Korrigieren direkt im Raster sortieren:
länger drücken und an die gewünschte Position ziehen. Am Bildschirmrand scrollt
das Formular mit. Das Fotomenü bietet außerdem „Nach vorne“ und „Nach hinten“.
Bei gespeicherten Projektständen mit mehreren Bildern führt „Fotos sortieren“
direkt oberhalb der Galerie in diesen Editor. „Korrektur protokollieren“ speichert
die neue Reihenfolge.
Neue Fotos werden angehängt. Beim Ersetzen bleibt die Position erhalten.
Eine reine Umsortierung wird als „Fotoreihenfolge geändert“ protokolliert.
Entfernte oder ersetzte gespeicherte Bilder sind nur noch
im Korrekturverlauf sichtbar und werden nicht in neue PDFs übernommen. Erst
„Korrektur protokollieren“ übernimmt Änderungen. Der Grund bleibt optional.

Vor Kamera-/Galerieaufrufen sichert die App den Fotoentwurf und die offenen
Formulareingaben intern auf dem Gerät. Nach einer Android-Prozessbeendigung kann
sie die Auswahl einschließlich mehrerer zurückgelieferter Fotos wieder aufnehmen.
Abbrechen räumt neue Dateien auf. Bereits gespeicherte Fotoversionen bleiben
bis zur Löschung des Projektstands oder Projekts erhalten.

Datenbankschema 5 liest alte Einzelfotos ohne Verlust. Neue Backups verwenden
Version 4. Backups der Versionen 1–3 bleiben importierbar, inklusive bestehender
Fotokorrekturen und gespeicherter PDFs.

Neue PDFs zeigen je Abschnitt „Projektstand 1“, „Projektstand 2“ usw. mit Reihe
oder Runde und Zeitpunkt über der ersten Fotozeile. Pro Zeile stehen zwei Fotos
nebeneinander. Ein einzelnes beziehungsweise letztes unpaariges Foto steht zentriert
in derselben Größe. Bilder werden vollständig und ohne Beschnitt angezeigt.
Die Bilder folgen der gespeicherten Reihenfolge, von links nach rechts und dann
von oben nach unten. Im Verlaufs-PDF verweisen die Nummern der Übersicht auf die passenden
Detailabschnitte. Die neuesten Stände stehen weiterhin zuerst. Die Nummern gelten
nur innerhalb des jeweiligen Dokuments.

Projekte zeigen die zehn neuesten Stände; vollständige Verläufe und gespeicherte
Verlaufs-PDFs sind paginiert. Korrekturgründe sind optional. Beim Löschen eines
Stands werden seine Fotos, Revisionen und Einzel-PDFs gelöscht; gespeicherte
Verlaufs-PDFs bleiben erhalten. Projektlöschung entfernt auch diese. Extern
geteilte Dateien bleiben bestehen.

Wiederherstellungen überschreiben keine unveränderten oder neueren lokalen
Stände. Fehlende/beschädigte Fotos werden anhand passender SHA-256-Prüfsummen
repariert. LeseLog- und ZählerLog-Backups sind keine Backups dieser App und
werden abgelehnt. Details: [Verarbeitungsparität](docs/PROCESSING_PARITY.md).

## Gestaltung

Creme `#FAF6EF`, warmes Weiß `#FFFCF7`, Salbeigrün `#526B59` und warme Wolltöne.
Material 3, abgerundete Karten, großzügige Schaltflächen, Hell- und Dunkelmodus.
Das App-Icon zeigt ein Wollknäuel mit Stricknadel und Häkelnadel; die editierbare
Quelle liegt unter `assets/branding/strick_haekelbuch_icon.svg`.
`python3 scripts/generate_icons.py` erzeugt die Plattformgrößen erneut
(benötigt Python GI, librsvg und Cairo).

## Entwicklung und Prüfungen

Flutter und Android SDK installieren und deren Werkzeuge in `PATH` aufnehmen.
Die App verwendet den mitgelieferten Dependency-Lockstand der Vorlage,
ausgenommen entfernte OCR-Pakete. `url_launcher` öffnet die Datenschutzerklärung
über die externe Browser- oder GitHub-App.

```bash
flutter pub get
dart format lib test
flutter analyze
flutter test --concurrency=2
```

Bei Änderungen an Drift-Generator-Eingaben zusätzlich:

```bash
dart run build_runner build
```

PDF-Textaudit mit Poppler (`pdftotext`):

```bash
TZ=UTC flutter test --dart-define=PDF_TEXT_AUDIT=true test/features/evidence/evidence_pdf_content_test.dart
TZ=Europe/Berlin flutter test --dart-define=PDF_TEXT_AUDIT=true test/features/evidence/evidence_pdf_content_test.dart
```

## Android

| Variante | App-Name | Paketkennung |
| --- | --- | --- |
| dev | Strick & Häkelbuch Dev | `com.appfactory.strick_haekelbuch.dev` |
| store | Strick & Häkelbuch | `com.appfactory.strick_haekelbuch` |

Startversion `1.0.0+1`. Store-Debug/Profile sind deaktiviert. Store-Release
benötigt eine eigene private Upload-Signatur gemäß `android/key.properties.example`.
Keystores und Passwörter bleiben außerhalb von Git. Es wurde kein Store-Release
oder Upload beauftragt. iOS-Bundle-ID: `com.appfactory.strickHaekelbuch`.

```bash
flutter run --flavor dev -d <device-id>
flutter attach --debug --app-id com.appfactory.strick_haekelbuch.dev -d <device-id>
```

Vor Attach die Sitzung eindeutig dieser App zuordnen. Für einen neuen nativen
Dev-Build, beispielsweise bei erster Installation mit eigener Identität:

```bash
flutter build apk --debug --flavor dev
adb -s <device-id> install -r -t -g --no-streaming build/app/outputs/flutter-apk/app-dev-debug.apk
```

Vor einem Update installierte Identität und Signatur prüfen. Kein `flutter install`
verwenden. Hot Reload/Restart aktualisiert die laufende Sitzung, nicht das APK.

Die native stündliche Zeitplanung wird mit `test/native/HourlyReminderCheck.java`
gegen die tatsächlich gebauten Kotlin-Klassen geprüft, einschließlich Sommerzeit.

## Browser-Vorschau

```bash
flutter run -d chrome --web-port=53545
# Fallback:
flutter run -d web-server --web-hostname=127.0.0.1 --web-port=53545
```

Eine bereits laufende fremde App-Sitzung auf diesem Port nicht beenden.
Wie LeseLog bietet Web eine UI-Vorschau mit flüchtigem Speicher. Kamera,
native Erinnerungen und vollständige Datei-/Backup-Abläufe erfordern Android.

## Datenschutz und Lizenz

Alle Projektinhalte werden lokal verarbeitet. Die Android-Release-App hat
keine Internetberechtigung. Keine Cloud, Analytics, Werbung oder KI-Dienste.
Die [Datenschutzerklärung](https://github.com/wasiliy-strecker/reading_progress_log/blob/main/PRIVACY.md)
ist öffentlich auf GitHub abrufbar und wird aus den Einstellungen extern geöffnet.
Dafür wird eine Internetverbindung benötigt. Projektinhalte werden dabei nicht
übergeben. PDFs sind private Dokumentation, kein amtlicher Zeitstempel.

Quellcode: [Mozilla Public License 2.0](LICENSE).
[Drittanbieterhinweise](THIRD_PARTY_NOTICES.md).
