# App internationalisiert und Dev-Übergabe abgeschlossen

457 zentrale ARB-Texte in Deutsch, Englisch, Spanisch, Französisch, Italienisch
und Portugiesisch (Brasilien) ergänzt. Systemsprachliste mit englischem Fallback,
dauerhafte manuelle Sprachwahl und unabhängige regionale Zahlen-/Datumsformate
implementiert. Neue PDFs und native Erinnerungen sind lokalisiert. Benutzerdaten,
exakte Werte, technische IDs, Backup-Format, alte PDFs und Integritätsnachweise
bleiben erhalten. Keine eigenen schwedischen oder norwegischen Kataloge.

Sechs direkt kopierbare Store-Textpakete, 84 echte Aufnahmen aus eigenen Emulatoren
mit synthetischen Beispielen sowie Icon und Feature-Grafik je Sprache erstellt.
Insgesamt 96 geprüfte Upload-Bilder, sechs Vorschauen und ein gemeinsames ZIP.
Englisch als Store-Standard vorbereitet. Übersetzungs- und Bildpflege dokumentiert.
Eine muttersprachliche Prüfung aller sechs Übersetzungen hat nicht stattgefunden.

Formatierung und statische Analyse erfolgreich. 505 Flutter-Tests, 35 Android-Tests,
32 PDF-Inhaltsaudits unter UTC und Europe/Berlin, 56 direkte JVM-Prüfungen,
sieben Store-Werkzeugtests und sechs synthetische Backup-Roundtrips bestanden.
Alle sechs Oberflächen bei normaler und vergrößerter Schrift geprüft.
Englischwahl nach Kaltstart und echte native englische Erinnerung im Emulator
zusätzlich geprüft. ZIP, Bildmaße, PNG-Modi und Artefakt-Prüfsummen validiert.

Vorhandene Smartphone-Dev-App mit passender Signatur datenbewahrend aktualisiert
und gestartet. Alle 31 bestehenden App-Datendateien blieben direkt beim Update
bytegleich. Installiertes APK entspricht der Übergabe. Version bleibt 1.0.0+1.
Kein Store-Build, kein AAB, kein Upload, keine Veröffentlichung oder Länderänderung.

Lieferung außerhalb des Build-Verzeichnisses unter dem Git-ignorierten
`releases/international/build-1/`. Eigene temporäre Emulatoren und Arbeitsdateien
entfernt. Gemeinsame Werkzeuge, Schlüssel und fremde Emulatoren erhalten.
Für den Nutzer bleibt ein kurzer Englischtest gemäß `START-HIER.txt`.

Die lokal abgegrenzten Runtime-Commits sind `cdffb6c` und `45bb96e`.
Dieser Abschluss ergänzt Store-Quellen, Aufnahmeautomation, Pflegeanleitung und
die aktualisierten Java-Prüffixtures für die neuen optionalen Erinnerungswerte.
Nicht gepusht.
