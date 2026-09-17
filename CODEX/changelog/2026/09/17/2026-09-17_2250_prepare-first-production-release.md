# Ersten Production-Release bereitstellen

Signierte Store-AAB für die erste Veröffentlichung von Strick & Häkelbuch
erstellt. Version 1.0.0, Buildnummer 1, Paket
`com.appfactory.strick_haekelbuch`, sichtbarer Name Strick & Häkelbuch.
Es gab noch keine frühere AAB-Lieferung, deshalb bleibt die initiale Version 1.

Einen eigenen privaten RSA-4096-Upload-Schlüssel außerhalb des Repositories
angelegt. Die ignorierte lokale Signaturkonfiguration verweist auf
`~/.local/share/app-factory/signing/strick-haekelbuch/`.
Keine Schlüssel einer anderen App übernommen und keine Geheimnisse committet.

App-lokalen Production-Build-Helfer mit Schutz vor überschriebenen Lieferungen
und falschen Paket-/Versionsmetadaten ergänzt. Release-Anleitung und fünf
isolierte Tests für die Lieferungsregeln hinzugefügt.

Lieferung unter `build/releases/production/`:
`strick-haekelbuch-1.0.0-build-1-production.aab`, 67.500.134 Bytes.
SHA-256: `834ab15c7f0492b91987b8c47e8fb4d7276d240942d477636fcb73f07c10cf6e`.
Dazu deutsche Versionshinweise mit Sprach-Tags, Release-Name, Upload-Anleitung
und Prüfberichte. Keine Installation auf dem Smartphone und kein Play-Upload.

Prüfung: Formatierung ohne Änderungen und statische Analyse ohne Befunde.
472 Flutter-Tests mit PDF-Audit unter UTC sowie 472 Tests der Store-Variante
unter Europe/Berlin erfolgreich. 25 native Store-Release-Testfälle mit vollständigem
JDK erfolgreich. Der erste native Testaufruf fand in der System-Java-Laufzeit
keinen Compiler und wurde mit dem vorhandenen vollständigen JDK wiederholt.
Fünf Tests des Release-Helfers, Shell-Syntax und Diff-Whitespace erfolgreich.

Bundletool bestätigt die gültige AAB-Struktur. Jarsigner bestätigt die Signatur,
das AAB-Zertifikat stimmt mit dem eigenen Upload-Zertifikat überein.
Manifest direkt aus der AAB geprüft: API 36, Mindest-API 24, kein Debug/Test-Flag,
kein Systembackup, keine Netzwerk- oder breiten Medienzugriffsrechte.
16-KB-Bundle-Ausrichtung und ELF-Segmente aller 64-Bit-Bibliotheken geprüft.
15 native Bibliotheken über ARM32, ARM64 und x86_64. Keine Testdatenbank oder
Demo-Backups im Bundle. Runtime-Code und Dev-Installation unverändert.
