# Übernahme von LeseLog

Referenz: `reading_progress_log` / LeseLog-Commit
`49b242e5d9dfa32c776d9ade3d6a2f1cf2a7e491` vom 15.09.2026.
Die Vorlage bleibt unverändert. Die neue App hat keine Abhängigkeit auf das
Nachbarverzeichnis; Testreferenzen sind app-lokal eingefroren.

## Beibehaltene Grundlagen der Verarbeitung

Exakte Zahlendarstellung, bestehende Drift-Migrationen und Indizes,
Repository-Verträge, Fotooptimierung und Dateispeicherung,
SHA-256-Integrität, Backup-Verschlüsselung und Konflikt-/Reparaturregeln,
PDF-Fotoaufbereitung, Zeitzonen, Suche und Pagination bleiben erhalten.
Korrekturen, historische Projekt-Snapshots, Fotoversionen und Löschregeln werden
weitergeführt. Manuelle Stände erzeugen keine leeren Fotoversionen.

`test/parity/processing_baseline.json` enthält SHA-256-Hashes der vorhandenen
Verarbeitungsreferenz-Dateien, neu eingefroren aus dem genannten LeseLog-Commit
vor Änderungen an der neuen App. Die zwei OCR-Dateien sind bewusst nicht Teil
der übernommenen Runtime. Die ursprünglichen Identitätsanpassungen betreffen
diese Dateien:

- `app_database.dart`: ausschließlich eigener Datenbankname und Temp-Präfix.
- `binary_backup_codec.dart`: ausschließlich eigene Formatkennung; dadurch sind
  auch die authentifizierten Header-/Asset-Daten app-spezifisch.

Zusätzliche beauftragte Änderungen sind in den folgenden Abschnitten beschrieben.
Die Ausnahmedatei enthält für jede betroffene Referenzdatei den
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
- Die Datenschutzerklärung beschreibt die Daten dieser App und ist im eigenen
  GitHub-Repository `wasiliy-strecker/reading_progress_log` öffentlich abrufbar.
  Die Einstellungen öffnen sie wie LeseLog über `url_launcher` extern. Die App
  übergibt ausschließlich die öffentliche URL, keine Projektinhalte.

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

## Erinnerungskorrekturen vom 16.09.2026

Die Korrekturen für Benachrichtigungsnavigation, Dashboard-Sperrstatus und
Android-Neuplanung werden in allen drei Apps mit derselben app-lokalen Logik
geführt. App-Kennungen, fachliche Texte und die jeweiligen Themes bleiben lokal.

- Das Antippen einer Erinnerung öffnet die Detailkarte über der aktuellen Seite.
  Zurück führt zum offenen Formular mit seinen ungespeicherten Eingaben.
- Das Dashboard prüft die Benachrichtigungsfreigabe je Erinnerungsart. Bei einer
  Sperre zeigt es den Grund und den passenden Zugang zu Android-Einstellungen.
  Nach Rückkehr wird der Zustand aktualisiert. Ein unbekannter Zustand wird
  nicht als bestätigte Zustellung dargestellt.
- Android speichert zusätzlich den ausstehenden Auslösezeitpunkt in den lokalen
  Erinnerungsmetadaten. Unveränderte Zeitpläne behalten diesen Termin auch bei
  verspäteter Zustellung, App-Start, Neustart oder erneuter Alarmfreigabe.
  Geänderte Zeitpläne und Änderungen der Systemzeit oder Zeitzone werden neu
  berechnet. Nach einem verarbeiteten Alarm wird die nächste Wiederholung geplant.
  Vorhandene Zeitpläne ohne diese Zusatzmetadaten bleiben lesbar.

Datenbank, Backup-Format und eingefrorene Verarbeitungs-Hashes bleiben unverändert.
Identische Ablaufprüfungen unter `test/app/reminder_flow_regression_test.dart`
und JVM-Prüfungen unter `test/native/ReminderScheduleUpdateCheck.java` sichern
das Verhalten app-lokal ab.

## Mehrere Fotos pro Projektstand

Die beauftragte Erweiterung führt Datenbankschema 5 mit nullable Fotolisten und
Fotoänderungen ein. Ein fehlendes Fotolistenfeld liest weiterhin das alte
Einzelfoto und erhält dessen bisherige Manifestdarstellung. Eine explizite leere
Liste kennzeichnet einen Stand ohne aktuelle Fotos. Historische Foto-IDs bleiben
erhalten. Neue Korrekturen speichern die geordneten IDs vor und nach der Änderung.

Kamera und Galerie ergänzen denselben Fotoentwurf. Galerieauswahl und
Android-Wiederherstellung übernehmen alle Bilder. Die vorhandene Optimierung
läuft nacheinander. Einzelne fehlerhafte Dateien verhindern die übrigen Importe
nicht. Der interne Entwurf sichert vor externen Picker-Aufrufen die Zuordnung,
die bisherigen Fotos und Formulareingaben. Neue verworfene Dateien werden
entfernt. Bereits gespeicherte aktuelle oder historische Dateien bleiben geschützt.

Backup-Version 4 sichert alle aktuellen und historischen Fotozuordnungen.
Version 3 wird mit ihren ursprünglichen authentifizierten Verschlüsselungsdaten
gelesen, die alten Versionen 1–2 bleiben unterstützt. Reparatur ordnet Dateien
weiterhin anhand ihrer Prüfsumme zu und überschreibt keine neueren Datensätze.
Die synthetische Version-3-Fixture stammt aus dem unveränderten bisherigen Codec.

Neue Einzel- und Verlaufs-PDFs enthalten alle aktuellen Fotos in gespeicherter
Reihenfolge. Das frühere Exportmerkmal `allPhotos` bleibt auf gespeicherten
Dokumenten lesbar, wird bei neuer Erzeugung aber zu `currentPhotos` normalisiert.
Historische Bilder werden nicht neu eingebettet. Vorhandene PDFs bleiben erhalten.

Die autorisierten Abweichungen sind in `processing_exceptions.json` mit
unveränderten Quell-Hashes und gezielten Regressionstests dokumentiert. Der
ursprüngliche Verarbeitungsvergleich wird nicht neu eingefroren.

Die Aktualisierung auf Schema 5 erkennt auch Datenbanken mit noch alter
Versionsnummer, in denen eine oder beide neuen Fotospalten bereits vorhanden
sind. Sie ergänzt nur fehlende Spalten und lässt deren vorhandene Inhalte
unverändert. So lässt sich ein teilweise abgeschlossener Wechsel beim nächsten
Start fortsetzen. Tests prüfen beide Zwischenstände, bereits vollständig
angelegte Spalten, die Projektübersicht und einen weiteren Kaltstart. Schema 5,
Fotolisten, Revisionen und Manifest-Prüfwerte bleiben erhalten.

## Fotoreihenfolge und PDF-Gliederung

Die vorhandenen geordneten Fotolisten werden jetzt im Erfassen- und Korrekturformular
per langem Drücken und Ziehen oder über das Fotomenü umgeordnet. Die Entwurfssicherung
übernimmt ausschließlich vollständige Permutationen der bestehenden Foto-IDs und
setzt bei Schreibfehlern die bisherige Reihenfolge zurück. Neue Foto-Dateien oder
Fotoversionen entstehen dabei nicht. Eine gespeicherte Umsortierung verwendet die
bestehenden Vorher-/Nachher-IDs und wird im Korrekturverlauf ausdrücklich benannt.

Neue PDFs zeigen eine nummerierte Projektstand-Überschrift und die Wert-/Zeittabelle
oberhalb des ersten Fotos. Weitere Fotos tragen die gleiche Projektstandnummer.
Die Verlaufsübersicht und Detailabschnitte zählen chronologisch ab dem ältesten
Stand mit Nummer 1. Der neueste Stand bleibt oben, bei drei Einträgen also in der
Reihenfolge 3, 2, 1. Kompakte Einträge ohne Detailabschnitt zählen mit und bleiben
in der Übersicht. Weitere Fotozeilen behalten die Nummer ihres Projektstands.
Gespeicherte PDF-Dateien werden nicht nachträglich geändert.

Schema 5, Backup-Version 4, Verschlüsselung und eingefrorene Paritätsdateien bleiben
unverändert. Sortierung, Rücknahme, Entwurfswiederherstellung, Backup-Reihenfolge
und PDF-Positionen sind durch gezielte Tests abgesichert.

## Kompakte PDF-Fotozeilen und sichtbarer Sortierzugang

Neue Einzel- und Verlaufs-PDFs ordnen aktuelle Fotos in Zeilen mit zwei gleich
breiten Bildfeldern an. Ein letztes unpaariges Foto, auch ein einziges Foto,
wird mit derselben Feldgröße zentriert. Das Seitenverhältnis bleibt erhalten,
es wird nichts abgeschnitten. Nummerierung und gespeicherte Reihenfolge bleiben
maßgeblich. Fotozeilen werden nicht über Seiten getrennt. Die erste Zeile bleibt
mit Überschrift und Wert-/Zeittabelle zusammen. Fehlende Fotos behalten ihren
beschrifteten Platz. Gespeicherte PDFs bleiben unverändert.

Die Projektstand-Detailseite zeigt bei mehreren aktuellen Fotos jetzt direkt
über der Galerie „Fotos sortieren“. Die Aktion öffnet den bestehenden
Korrektureditor. Erst dessen Speichern übernimmt die Reihenfolge und schreibt
die Revision. Die Anzeige allein verändert keine Daten.
