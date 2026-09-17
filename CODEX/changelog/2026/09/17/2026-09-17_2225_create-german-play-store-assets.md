# Deutsche Play-Store-Bilder erstellen

18 Upload-Bilder für Strick & Häkelbuch erstellt. App-Icon 512 × 512,
Feature-Grafik 1024 × 500, acht Smartphone-Motive 1080 × 1920 und jeweils
vier echte Tablet-Aufnahmen mit 1920 × 1080 beziehungsweise 2560 × 1440 Pixeln.
Die Ausgabe enthält eine Gesamtvorschau, deutsche Alt-Texte, eine Upload-Zuordnung,
ein Manifest mit Herkunft und SHA-256 sowie ein ZIP mit 21 Dateien.

Die Bilder zeigen die aktuelle Android-App mit drei erfundenen Projekten,
24 Projektständen und vorhandenen synthetischen Handarbeitsfotos. Der eigens
gebaute Dev-Profile-Build wurde ausschließlich im frischen Aufnahme-Emulator
installiert. Das angeschlossene Nutzergerät wurde nicht verwendet.
Mehrfachauswahl, Fotokorrektur mit gespeicherter neuer Reihenfolge, Erinnerung
und PDF-Vorschau wurden über die reale Oberfläche bedient. Tablet-Fotos wurden
separat bei passender Geometrie aufgenommen. Smartphone-Überschriften und
Feature-Grafik verwenden die vorhandene grüne Markenfarbe, Roboto und das App-SVG.

App-lokale Werkzeuge und eine Wiederholungsanleitung unter `scripts/store_assets/`
ergänzt. Der neue Host-Test erstellt ein reguläres verschlüsseltes Demo-Backup
und prüft den Import einschließlich Foto-Reihenfolge und Integrität.
Runtime, Datenbankschema, Backup-Format und Release-Version bleiben unverändert.
Generierte Ausgabedateien liegen ignoriert unter
`build/store-assets/de-DE/2026-09-17_2202/`.

Prüfung: `dart format lib test` ohne Änderungen. `flutter analyze --no-pub`
ohne Befunde. 20 fokussierte Flutter-Tests einschließlich Demo-Backup,
Mehrfachfoto-Backup, PDF-Fotos und PDF-Fotoraster erfolgreich. Sechs Python-Tests
für Gerätebegrenzung, Bildvalidierung, Alt-Texte und APK-Herkunft erfolgreich.
JavaScript- und Shell-Syntax sowie Diff-Whitespace geprüft. Alle 18 Upload-Bilder
visuell und hinsichtlich Format, Maßen, Dateigröße und PNG-Dekodierung geprüft.
ZIP-Inhalt und Prüfsummen geprüft. Kein Play-Upload.
