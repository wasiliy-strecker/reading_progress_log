# Bildverwaltung prüfen und Fehlerfälle absichern

- Einzel- und Mehrfachfotos für Erfassung und Korrektur geprüft. Abgedeckt sind
  Kamera, Galerie, Ersetzen, Entfernen, Sortieren, Abbrechen, Wiederherstellung,
  Korrekturverlauf sowie die Übergänge zwischen keinem, einem und mehreren Fotos.
- Vier Fehlerfälle mit zunächst fehlschlagenden Tests nachgewiesen und behoben.
  Entfernen sperrt weitere Fotoaktionen bis zum Ende der Speicherung.
  Ein fehlgeschlagener Fotoersatz stellt die bisherige Liste wieder her und
  entfernt die neu importierte Datei. Schließen wartet auf laufende
  Entwurfsschreibvorgänge, damit kein verworfener Entwurf zurückkehrt.
  Bei fehlgeschlagener Picker-Wiederherstellung bleiben Zahl, Notiz und
  Korrekturgrund sichtbar. Die abgeschlossene Picker-Operation wird zurückgesetzt.
- Gleichzeitiges Aufräumen und Schließen teilen laufende Dateilöschungen,
  sodass eine temporäre Datei nur einmal gelöscht wird. Gespeicherte und
  historische Fotos bleiben beim Verwerfen geschützt.
- Elf zusätzliche Tests für Fehlerfälle, abgebrochene Auswahl, teilweise
  fehlerhafte Mehrfachauswahl, Entfernen sämtlicher Fotos, späteres Ergänzen
  und Sortieren. Fotoänderungen erhalten Projektstand und Erfassungszeitpunkt.

## Prüfung

- `dart format lib test` und `flutter analyze --no-pub` erfolgreich.
- `flutter test --no-pub --concurrency=2 --timeout=2m --reporter expanded`:
  444 Tests bestanden, einschließlich Backup, PDF, Datenbank und Integrität.
- `git diff --check` erfolgreich. Keine Änderungen an Datenformaten,
  Generator-Eingaben oder eingefrorenen Paritätshashes.

## Gerät

- Bestehende Dev-App auf dem verbundenen Android-Gerät in den Vordergrund
  gebracht, ohne das Gerät zu entsperren oder die App neu zu starten.
  VM-PID und Root-Library vor Attach eindeutig der Strick-App zugeordnet.
- Hot Reload erfolgreich. Alle drei geänderten Laufzeitdateien stimmen in der
  laufenden VM exakt mit dem Arbeitsstand überein. Dev-Sitzung bleibt offen.
- Keine manuellen Kamera- oder Galerie-Systemdialoge am gesperrten Telefon
  durchgespielt. Die automatisierten Abläufe verwenden kontrollierte Picker.
- Kein APK-Build und keine Installation. Das Update gilt für die laufende
  Sitzung und ist nach einem Kaltstart nicht dauerhaft vorhanden.
