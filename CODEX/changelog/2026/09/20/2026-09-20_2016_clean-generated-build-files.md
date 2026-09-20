# Build- und Cache-Dateien bereinigt

Auf Nutzerwunsch ausschließlich erzeugte Flutter-/Android-Build-Dateien und
`.dart_tool` entfernt. Das gibt rund 5,59 GB Speicher frei.
Der nächste Build erzeugt die benötigten Zwischenstände erneut.

Erhalten: `build/releases`, `build/reports`, `build/store-assets`, `build/verification`.
Quellcode, Konfiguration, persönliche Dateien und Gateway-Verzeichnisse wurden
nicht bereinigt. Es wurden keine Apps installiert, beendet oder deinstalliert.

## Prüfung

Vor der Bereinigung keine aktiven Prozesse mit Zugriff auf die Zielverzeichnisse
festgestellt. Keine versionierten Dateien lagen innerhalb der Löschziele.
Nach der Bereinigung waren alle 22 freigegebenen Ziele entfernt.
Die SHA-256-Prüfsummen beziehungsweise Symlink-Ziele von 390
geschützten Dateien waren unverändert. Der bestehende Git-Status blieb erhalten.

Nur dieser Changelog wird versioniert. Inhalt und Git-Diff auf Formatfehler
geprüft. Keine Code-, Analyse-, Test- oder Build-Ausführung erforderlich,
da weder Laufzeitcode noch Projektkonfiguration geändert wurden.
