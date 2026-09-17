# Android-Releases für Strick & Häkelbuch

Play-Tests und Production verwenden dieselbe signierte Store-Variante.
Paketkennung: `com.appfactory.strick_haekelbuch`. App-Name: **Strick & Häkelbuch**.
Die eigenständige Dev-Variante verwendet weiterhin `.dev` und ihren eigenen
Datenbestand. Für eine AAB wird kein Smartphone benötigt und keine APK installiert.

## Private Upload-Signierung

Für den ersten Release wurde ein eigener RSA-4096-Upload-Schlüssel erstellt.
Keystore, private Gradle-Konfiguration und öffentliches Upload-Zertifikat liegen
auf diesem Rechner unter `~/.local/share/app-factory/signing/strick-haekelbuch/`.
Das Verzeichnis ist nur für den lokalen Eigentümer zugänglich. Die ignorierte
Datei `android/key.properties` verweist auf die private Konfiguration dort.

Die Dateien heißen `upload-keystore.p12`, `key.properties` und
`upload-certificate.pem`. Der Alias ist `upload`. Die Konfiguration enthält
die Passwörter und einen absoluten Keystore-Pfad. Keystore und Konfiguration
gehören nicht in Git, in das AAB-Ausgabeverzeichnis oder in Release-Notizen.
Diese privaten Dateien für spätere Uploads behalten und separat sicher sichern.
Keine Signatur einer anderen App übernehmen oder einen bestehenden Schlüssel
neu erzeugen. Google Play kann für die ausgelieferten Apps einen eigenen
App-Signing-Schlüssel verwenden. Dieser unterscheidet sich vom Upload-Schlüssel.

## Version und Prüfungen

Der erste Production-Release ist `1.0.0+1`. Dafür existierte noch keine frühere
AAB-Lieferung. Bei weiteren Uploads die Zahl hinter `+` in `pubspec.yaml` erhöhen.
Für die unveränderte Datei desselben Releases keine neue Buildnummer vergeben.
Ein bereits geliefertes AAB nicht überschreiben. Normale Dev-Arbeit benötigt
keine Versionsanhebung.

Vor jedem Release aus dem App-Verzeichnis ausführen:

```bash
dart format lib test
flutter analyze --no-pub
TZ=UTC flutter test --no-pub --dart-define=PDF_TEXT_AUDIT=true
TZ=Europe/Berlin flutter test --no-pub --flavor store --dart-define=PDF_TEXT_AUDIT=true
python3 -m unittest discover -s scripts -p 'test_production_release.py'
bash -n scripts/build_production_aab.sh
git diff --check
```

Die PDF-Audits brauchen Poppler mit `pdftotext`, `pdftohtml` und `pdfimages`.
Die Android-Tests aus dem Ordner `android/` mit einem vollständigen JDK ausführen.
Die System-Java-Laufzeit dieses Rechners enthält keinen Compiler. Deshalb hier
das installierte JDK ausdrücklich auswählen:

```bash
JAVA_HOME=/home/unknown/.local/jdk-21 ./gradlew :app:testStoreReleaseUnitTest --no-daemon --max-workers=2
```

Codegenerierung nur bei geänderten Generator-Eingaben ausführen. Der aktuelle
Flutter-SDK-Stand setzt Compile- und Target-SDK auf Android 16 / API 36.
Die tatsächlichen SDK-Werte immer auch im gebauten Bundle prüfen.

## Production-AAB bauen

```bash
./scripts/build_production_aab.sh
```

Bei Bedarf `FLUTTER_BIN` auf das Flutter-Programm setzen. Der Helfer benötigt
Bash, Flutter, `jq` und Python 3. Er akzeptiert keine Argumente und baut
ausschließlich `--release --flavor store`. Paket, Variante und Version werden
vor der Lieferung anhand der Build-Metadaten geprüft. Die benannte Datei liegt
außerhalb von Flutters automatisch erzeugtem Bundle-Verzeichnis:

`build/releases/production/strick-haekelbuch-<version>-build-<code>-production.aab`

Ein vorhandenes Ziel wird geschützt. Ein fehlgeschlagener Build oder unpassende
Metadaten dürfen keine neue benannte Lieferung ergeben. Die Tests des Helfers
prüfen diese Fälle ohne echte Signaturschlüssel oder Flutter-Builds.

## Das fertige Bundle prüfen

Das offizielle [bundletool](https://developer.android.com/tools/bundletool)
und `jarsigner` aus einem vollständigen JDK verwenden. Die eigentliche AAB-Datei
mit `bundletool validate` und `jarsigner -verify` prüfen. Das Zertifikat der AAB
muss dem eigenen öffentlichen Upload-Zertifikat entsprechen. Selbstsignierte
Upload-Zertifikate sind hier vorgesehen.

Mit `bundletool dump manifest --module=base` die gebauten Werte prüfen:

| Eigenschaft | Erwartung |
| --- | --- |
| Paket | `com.appfactory.strick_haekelbuch` |
| Version | Versionsname und Buildnummer aus `pubspec.yaml` |
| App-Name | Strick & Häkelbuch |
| Debuggable / Test-only | Nicht aktiviert |
| Android-Systembackup | `allowBackup=false` |
| Netzwerkrechte | Kein `INTERNET` und kein `ACCESS_NETWORK_STATE` |
| Bilderzugriff | Keine breiten Medien- oder Speicherrechte |
| Native Bibliotheken | 16-KB-fähige ELF-Segmente für die 64-Bit-ABIs |

Zusätzlich mit `bundletool dump config` die 16-KB-Ausrichtung im Bundle prüfen.
Die Anforderungen beschreibt [Android – 16 KB page sizes](https://developer.android.com/guide/practices/page-sizes).
SHA-256, Dateigröße, Signatur-Fingerprint und geprüfte Bundle-Metadaten mit der
Lieferung dokumentieren. Das AAB enthält keine Demo-Backups oder Testdatenbank.
Die vorhandenen synthetischen Projektbeispiele sind reguläre App-Assets.

## Übergabe

Den Ordner mit der geprüften AAB öffnen. Den genauen Dateinamen, einen kurzen
Release-Namen und deutsche Versionshinweise mit `<de-DE>`-Tags bereitstellen.
Notizen als direkt kopierbare Absätze ohne Aufzählungszeichen formulieren.
Der Nutzer lädt die Datei in der Play Console unter Production hoch.
Automatischer Upload oder Veröffentlichung benötigt einen eigenen Auftrag.
