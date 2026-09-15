# Strick & Häkelbuch repository guide

Eigenständige Android-first Flutter-App der App Factory. Zusätzlich gelten die
Vorgaben aus `../AGENTS.md`, sofern dieser Ordner in der App Factory liegt.
Ohne Nachbar-Apps baubar bleiben; keine gemeinsame Runtime einführen.

Feature-first Clean MVVM mit Riverpod, Use Cases und austauschbaren Repositories
beibehalten. Interne `Meter`-/`Reading`-Bezeichner stammen aus der Vorlage;
`label` ist der Projektname, `meterNumber` das Garn, `location` die Nadelstärke.
Techniken sind `knitting` und `crochet`; Zählweisen `Reihen` und `Runden`.
Neue Projekte starten mit Stricken/Reihen. Die Technik bestimmt nicht die Einheit.

Projektstände werden manuell als ganze Zahlen ab 0 eingegeben. Fotos dienen nur
der Dokumentation. Keine OCR, KI-Erkennung oder automatische Reihen-/Rundenzählung
hinzufügen. Bestehende OCR-Felder in gespeicherten Datensätzen bleiben aus Gründen
der minimalen Übernahme erhalten, für neue Einträge aber leer beziehungsweise null.
Zahlen werden weiterhin exakt als Ziffern und Dezimalskala gespeichert.

Korrekturen erzeugen `ReadingRevision`; Gründe sind optional. Manuelle Einträge
haben keine Fotoversion. Später ergänzte Fotos dürfen keine leere Fotoversion
archivieren. Ein Fotowechsel verändert den eingegebenen Projektstand nicht.
Foto-, Manifest- und PDF-Prüfsummen, Verschlüsselung, Revisionen, Löschregeln und
Wiederherstellungsverhalten nicht als Stylingänderung vereinfachen.

## Prüfungen

Referenz: LeseLog `49b242e5d9dfa32c776d9ade3d6a2f1cf2a7e491`.
Übernahme und Ausnahmen sind in `docs/PROCESSING_PARITY.md` dokumentiert.
Eingefrorene Quell-Hashes nicht aktualisieren, um Fehler zu umgehen.

Vor Code-Commits: `dart format lib test`, `flutter analyze`, passende Tests;
bei übergreifenden Änderungen die gesamte Suite mit `flutter test`.
Codegen nur bei geänderten Generator-Eingaben/-Konfiguration.
PDF-Audits: `TZ=UTC flutter test --dart-define=PDF_TEXT_AUDIT=true
 test/features/evidence/evidence_pdf_content_test.dart` und mit
`TZ=Europe/Berlin`. Dokumentationsänderungen benötigen nur Diff-/Inhaltsprüfung.

## Identität und Gerätetests

- Dev: `com.appfactory.strick_haekelbuch.dev`, **Strick & Häkelbuch Dev**.
- Store: `com.appfactory.strick_haekelbuch`, **Strick & Häkelbuch**.
- iOS: `com.appfactory.strickHaekelbuch`.
- Version zum Start: `1.0.0+1`; Dev-Arbeit ist kein Release-Grund.

`flutter run --flavor dev -d <device-id>` verwenden. Reine Dart-/UI-Änderungen
zuerst per Hot Reload, bei Initialisierungsänderungen Hot Restart. Vor Attach
VM-PID und Root-Library der richtigen App zuordnen; fremde Sitzungen erhalten.

APK nur bei nativen Änderungen, neuer Identität, nicht live aktualisierbaren
Assets, fehlender Dev-Installation oder ausdrücklich gewünschtem APK-Update.
Vor Installation Paketkennung, installierte Version, Debug-Flag und Installer
prüfen; bei Signaturunsicherheit Zertifikate vergleichen.

```bash
flutter build apk --debug --flavor dev
adb -s <device-id> install -r -t -g --no-streaming build/app/outputs/flutter-apk/app-dev-debug.apk
```

Niemals `flutter install`, `adb uninstall` oder `pm clear` ohne ausdrücklichen
Auftrag zur Datenlöschung. Keine Store-App mit lokalem Dev-APK ersetzen.
Store-Debug/Profile sind gesperrt; Release-Signierung ist privat und app-lokal.
Keine fremden Signaturdateien übernehmen, keine Geheimnisse oder Nutzerdaten
committen. Backups haben die Endung `.shbackup` und eine eigene Formatkennung.

Browser vorzugsweise `http://localhost:53545/`. Keine fremde Sitzung übernehmen.
Wie die Vorlage ist Web nur eine UI-Vorschau mit flüchtiger Speicherung;
Fotoaufnahme, vollständiger Export/Backup und Erinnerungen werden nativ geprüft.

Für abgeschlossene Aufgaben einen Changelog unter `CODEX/changelog/YYYY/MM/DD/`
in lokaler Zeit und nach erfolgreichen Prüfungen einen lokalen Commit erstellen.
Kein Push oder Upload ohne Auftrag.
