# Übernahme von LeseLog

Referenz: `reading_progress_log` / LeseLog-Commit
`49b242e5d9dfa32c776d9ade3d6a2f1cf2a7e491` vom 15.09.2026.
Die Vorlage bleibt unverändert. Die neue App hat keine Abhängigkeit auf das
Nachbarverzeichnis; Testreferenzen sind app-lokal eingefroren.

## Unverändert übernommene Verarbeitung

Exakte Zahlendarstellung, Drift-Schema 4 mit Migrationen und Indizes,
Repository-Implementierungen, Fotooptimierung und Dateispeicherung,
SHA-256-Integrität, Backup-Verschlüsselung und Konflikt-/Reparaturregeln,
PDF-Fotoaufbereitung, Zeitzonen, Suche und Pagination bleiben erhalten.
Korrekturen, historische Projekt-Snapshots, Fotoversionen und Löschregeln werden
weitergeführt. Manuelle Stände erzeugen keine leeren Fotoversionen.

`test/parity/processing_baseline.json` enthält SHA-256-Hashes der vorhandenen
Verarbeitungsreferenz-Dateien, neu eingefroren aus dem genannten LeseLog-Commit
vor Änderungen an der neuen App. Die zwei OCR-Dateien sind bewusst nicht Teil
der übernommenen Runtime. Von den übrigen Dateien weichen nur diese ab:

- `app_database.dart`: ausschließlich eigener Datenbankname und Temp-Präfix.
- `binary_backup_codec.dart`: ausschließlich eigene Formatkennung; dadurch sind
  auch die authentifizierten Header-/Asset-Daten app-spezifisch.

Diese Diffs wurden gegen die Quelle geprüft. Die Ausnahmedatei enthält den
unveränderten Quell-Hash, lokalen Hash, Grund und zugehörige Regressionstests.
Quell-Hashes dürfen nicht zur Reparatur fehlgeschlagener Prüfungen geändert werden.

## Beauftragte fachliche Anpassungen außerhalb der Hash-Dateien

- Technik `knitting`/`crochet`, Zählweise Reihen/Runden. Garn und Nadelstärke
  belegen vorhandene Metadatenfelder. Interne Meter-/Reading-Namen bleiben
  erhalten, damit diese Umsetzung kein umfassender Architekturumbau wird.
- Fotoaufnahme, Wiederherstellung verlorener Aufnahmen und Fotokorrektur rufen
  keine Erkennung auf. Die Service-Methoden `create` und `update` benötigen
  keine OCR-Argumente. Eine Fotokorrektur verändert niemals die manuelle Zahl.
  Speicherfelder für OCR bleiben für die minimale Übernahme erhalten, neue
  Einträge schreiben leere Texte und null-Konfidenz. ML-Kit und Buchseiten-Demos
  einschließlich ausschließlich dafür zuständiger Tests entfallen.
- Die Projektzählweise wird am Projekt eingestellt. Historische Stände behalten
  ihre Einheit. Die bereits vorhandene Sperre für Differenzen zwischen
  unterschiedlichen Einheiten bleibt aktiv.
- Alle UI-/Reminder-/PDF-Texte und Farben erhalten die neue Fachsprache.
  PDF-Seitenzahlen behalten selbstverständlich ihre Bedeutung als Dokumentseite.
- Eigene Plattformkennungen, native Kanäle, Datenpfade und `.shbackup`-Dateien.
  Die Formatkennung lautet in allen Backup-Pfaden `strick_haekelbuch_backup`.
  Fremde Backups werden vor Schreiboperationen abgewiesen; keine Migration von
  LeseLog-Daten oder -Installationen.
- Die bestehende Datenschutzerklärung ist app-lokal und offline zugänglich;
  GitHub-Verweise auf die Vorlage oder auf nicht veröffentlichte Ziele entfallen.

## Android-Erinnerungshinweise

Der DND-Hinweis aus LeseLog (`8dec1f0`, Textkorrektur `a274907`) wurde
app-lokal übernommen und um die Prüfung gesperrter App-Benachrichtigungen
und einzelner Erinnerungsarten ergänzt. Es gilt die Reihenfolge App-Sperre,
Kanalsperre und „Nicht stören“. Die Statusabfragen fordern keine zusätzliche
Berechtigung an und verändern keine Android-Einstellungen. Unbekannte Zustände
werden nicht als Freigabe oder erkannte Sperre dargestellt.

Einstellungslinks führen zur betroffenen Kategorie oder zur App-Freigabe,
mit Rückfall auf allgemeinere Einstellungsseiten und manueller Anleitung bei
Fehlern. Der DND-Link fällt auf die Toneinstellungen zurück. Die Anzeige wird
bei Rückkehr, Fokus- und Moduswechsel sowie beim Testen aktualisiert.

Testbenachrichtigungen bleiben bis zu 60 statt 10 Sekunden bestehen. Eine
bekannte Kanalsperre verhindert auch nativ eine vermeintliche Testbestätigung
oder einen neuen Auslösezeitpunkt einer regulären Erinnerung. Die nächste
geplante Erinnerung wird unabhängig davon wie bisher eingerichtet.

Projekte lassen sich bei gesperrten Benachrichtigungen weiterhin speichern.
Die Rückmeldung benennt die Sperre und bietet einen Einstellungslink an. Nach
erneut erteilter App-Freigabe werden gespeicherte Zeitpläne erneut abgeglichen.
Offene Eingaben bleiben davon getrennt. Gleichzeitige Statusabfragen und
Abgleiche sind gegen veraltete Antworten und überlappende Wiederholungen geschützt.
Die vorhandenen Kanal-IDs, gespeicherten Zeitpläne und Datenformate bleiben
kompatibel. Die eingefrorenen Quell-Hashes sind unverändert.

## Prüfstrategie

Die übernommene Suite prüft Speicherung, manuelle Eingabe, Foto-Lebenszyklus,
Revisionen, PDF-Inhalt/Layout, verschlüsselte Backups, Reparatur, Löschung und
Erinnerungen. OCR-spezifische UI-Tests werden in Foto-/manuelle Eingabetests
überführt; Erkennungs-Kandidaten und freie Einheiten sind keine App-Funktionen.
Neue Projektprüfungen decken beide Techniken mit beiden Einheiten und
Metadaten-Snapshots ab. PDF-Textaudits laufen unter UTC und Europe/Berlin.

Die native stündliche Zeitplanung wird nach dem Dev-Build mit dem übernommenen
JVM-Check gegen die gebauten Kotlin-Klassen geprüft. Android-Identität und
Manifest werden am erzeugten Dev-APK kontrolliert. iOS wird in dieser
Linux-Umgebung konfiguriert, aber nicht gebaut. Web bleibt eine flüchtige
Oberflächenvorschau wie in der Vorlage.

## Einheitliche Erinnerungen und Rückkehr aus Android-Einstellungen

Die Erinnerungs-Schnittstelle und Wiederplanung entsprechen nun in LeseLog,
ZählerstandLog und Strick & Häkelbuch demselben Verhalten. App- und Kanalsperren
werden getrennt ausgewertet, auch unmittelbar vor einer nativen Zustellung.
Testergebnisse unterscheiden Übergabe, Sperren, Fehler und nicht unterstützte
Plattformen. „Nicht stören“ bleibt ein unabhängiger Status. Fehlende Ergebnisse
werden nicht als erteilte Freigabe oder bekannte Sperre ausgegeben.

Nach erneuter Benachrichtigungsfreigabe werden ausschließlich gespeicherte
Zeitpläne abgeglichen. Native Kanal-IDs, Paketkennungen und Datenformate bleiben
unverändert. Testbenachrichtigungen verschwinden nach einer Minute, und die
Erfolgsrückmeldung erklärt den Zugang über die Benachrichtigungsleiste.

Flutter und GoRouter stellen die Navigation nach einer Android-Prozessbeendigung
wieder her. Die Bearbeitungsseite erhält dieselbe Datensatz-ID und lädt die
bereits gespeicherten Daten. Das führt keine dauerhafte Speicherung ungesicherter
Eingaben ein. Prüfungen erstellen ausdrücklich einen neuen Router, prüfen den
aktuellen Berechtigungsstatus sowie den Zurück-Weg und laufen ohne Smartphone.
