# Mehrfoto-Stand dauerhaft auf dem Smartphone aktualisiert

## Ursache und Behebung

- Der Screenshot zeigte den früheren Korrektureditor mit einem Einzelfoto.
  Die laufende VM bestätigte diesen Code sowie Backup-Version 3. Die zuletzt
  ausgewählte Backup-Datei trägt laut unverschlüsseltem Header Version 4.
- Die installierte Dev-APK stammte vom 16.09.2026 um 20:23 Uhr und enthielt die
  späteren Mehrfoto-, Sortier- und PDF-Änderungen nicht dauerhaft. Der Einstieg
  über „Stand eintragen“ war keine Einschränkung der aktuellen Implementierung.
- Auf ausdrücklichen Auftrag den geprüften Stand `d5c2688` als Dev-APK gebaut
  und mit `adb install -r -t -g --no-streaming` aktualisiert. Keine Änderungen
  an Laufzeitcode, Datenformaten oder Versionsnummer nötig.
- Paket `com.appfactory.strick_haekelbuch.dev`, Version `1.0.0+1`, Debug-Flag und
  fehlenden Installer vor dem Update geprüft. Installierte und neue APK haben
  denselben SHA-256-Signaturfingerabdruck. Installation am 17.09.2026 um 06:36 Uhr
  erfolgreich. Keine Deinstallation und keine Datenlöschung.

## Prüfungen

- `flutter analyze`: keine Probleme.
- 78 gezielte Flutter-Tests für Backup, Mehrfachfotos, Korrektur, Sortierung,
  Erfassung, Fotoablage und Entwurfswiederherstellung erfolgreich. Einschließlich
  Mehrfoto-Backup und Lesbarkeit älterer Backups.
- `flutter build apk --debug --flavor dev`: erfolgreich.
- Vor dem Update keine Erfassungs-/Korrekturformular-Instanzen und kein
  Passwortdialog in der VM vorhanden. Keine laufende Backup-Operation.
- Alle zehn zuvor erfassten Dateien in `app_flutter`, `files` und `shared_prefs`
  waren unmittelbar nach der Installation vorhanden und per SHA-256 unverändert.
  Nach dem Kaltstart änderten sich nur Flutter-Laufzeitressourcen und der
  Profilinstallationsmarker. Datenbank, gespeichertes Foto und Einstellungen
  blieben unverändert.
- Nach dem Kaltstart VM-PID und Root-Library der richtigen App geprüft. Geladene
  Quellen bestätigen Mehrfoto-Korrektureditor, Galerie-Hinzufügen, Backup-Version
  4 und PDF-Fotozeilen. Keine Flutter-Exception-Marker im Startprotokoll.
- Keine visuellen Gerätetests. Das Nutzer-Backup wurde nicht verändert oder
  importiert. Die vollständige Wiederherstellung erfolgt über den bestehenden
  Passwort- und Bestätigungsdialog.

## Artefakt

- `build/app/outputs/flutter-apk/app-dev-debug.apk` bleibt außerhalb von Git.
- SHA-256: `e51bb5d483fa8c5961a17e1724485a0d25309373aea3311630f6b51b28f44b47`.
