# Sprachen und regionale Formate

Die Oberfläche unterstützt Deutsch, Englisch, Spanisch, Französisch, Italienisch
und Portugiesisch (Brasilien). Standard ist `system`. Die erste unterstützte
Sprache der Gerätepräferenzliste gewinnt, andernfalls Englisch. Andere Varianten
des Portugiesischen verwenden ebenfalls die brasilianischen Texte. Es gibt keine
eigenen schwedischen oder norwegischen Kataloge.

Die dauerhafte Auswahl steht in den normalen Einstellungen, ohne Dev-Schalter.
Android speichert sie in `app_locale_settings`, damit auch Erinnerungen ohne
laufenden Flutter-Prozess die aktuelle Sprache lesen. Andere Plattformen verwenden
SharedPreferences. App-Sprache und tatsächliche Gerätesprache werden getrennt
übergeben. Die App setzt keine globale Android-Systemsprache.

Zahlen und Datumsangaben verwenden die erste Geräteregion und die systemweite
24-Stunden-Einstellung. Manuelles Englisch auf einem deutschen Gerät lässt daher
`1.234,500` und `31.12.2026` bestehen. Der Datepicker verwendet dasselbe regionale
Muster zum Anzeigen und zum strikten Einlesen. Neue Projektstände bleiben ganze
Zahlen ab null. Alte Werte werden niemals aus lokalisierten Anzeigetexten neu
interpretiert. Exakte Ziffern und Skala bleiben erhalten, auch oberhalb der
Double-Genauigkeit. Die Suchanfrage wird nur bei einem vollständigen gültigen
regionalen Datum in das bestehende Suchformat übersetzt.

Mengenabhängige Einheiten verwenden zentrale ICU-Pluralregeln. Die Auswahl der
Grammatik erfolgt aus den exakten Ziffern und der Skala. Auch negative Differenzen,
Null, alte Dezimalwerte und sehr große Werte werden dabei nicht gerundet. Android
verwendet dieselben Regeln für Erinnerungen und lässt alte zwischengespeicherte
Werte ohne kanonische Ziffern weiterhin unverändert.

Namen, Notizen, technische Enum-Werte und die gespeicherten Einheiten `Reihen` und
`Runden` bleiben unverändert. Datenbankschema, Backup-Version, Prüfsummen und alte
Revisionen ändern sich nicht. PDF-Aufträge erfassen Sprache und Region beim Start.
Ein Worker erhält diese Momentaufnahme ausdrücklich. Vorhandene PDFs bleiben
unveränderte Dateien. Native Erinnerungen verwenden die Sprache bei Zustellung.
Ein Sprachwechsel ändert keine Alarmtermine und keine Benachrichtigungskanal-IDs.

## Übersetzungen pflegen

`lib/l10n/app_en.arb` ist die Vorlage. Alle sechs ARB-Dateien enthalten dieselben
Schlüssel. Platzhalter erhalten Typen und Kontextbeschreibungen. Mengen verwenden
ICU-Pluralformen. Neue sichtbare Texte über `stringsOf(context)` einbinden.
Kontextfreie bestehende Dienste verwenden `appStrings`. Benutzertexte dürfen nie
als Übersetzungsschlüssel dienen. Längere asynchrone Dokumentaufträge erhalten eine
`AppLocaleData`-Momentaufnahme.

Nach Änderungen an Katalogen:

```bash
flutter gen-l10n
python3 scripts/generate_native_localizations.py
python3 scripts/check_localizations.py
dart format lib test
flutter analyze
flutter test --timeout 3m --concurrency 2 --dart-define=PDF_TEXT_AUDIT=true
```

Die generierten Dart-Dateien werden mit versioniert. Native Android-Texte werden
nur aus dem definierten ARB-Teilsatz erzeugt. `--check` prüft veraltete Ressourcen.
Für neue native Meldungen zuerst den Generator erweitern. Keine parallelen
handgepflegten Android-Übersetzungen anlegen.

`localization_test.dart` prüft Auflösung, Persistenz, exakte Zahlen und Datumseingabe.
`localization_ui_test.dart` prüft alle Sprachen auf schmalem Bildschirm mit normaler
und vergrößerter Schrift sowie den Erhalt offener Eingaben beim Sprachwechsel.
`localized_pdf_test.dart` prüft neue übersetzte PDFs und unveränderte alte Dateien.
`AppLocaleTest.kt` prüft native Erinnerungen unter Android 24 und 35.
Die bestehenden Backup-, Foto-, Datenbank-, Integritäts- und PDF-Audits weiterführen.

## Store-Unterlagen

Die einzeln kopierbaren Textfelder liegen unter `store-listings/<Locale>/`.
`default-language.txt` bereitet Englisch als Store-Standard vor. Das ändert weder
App-Sprache noch Länderfreigaben und veröffentlicht nichts. Die sechs Fixture-
Dateien unter `scripts/store_assets/locales/` enthalten synthetische Projektnamen,
Notizen und Bildüberschriften. Keine privaten Daten verwenden.

Der reproduzierbare Aufnahmeablauf steht in `scripts/store_assets/README.md`.
Lieferungen bleiben unter dem ignorierten `releases/international/build-<Code>/`.
Bereits gelieferte Fassungen nicht überschreiben. Für reine Dev-Arbeit die Version
nicht erhöhen. Der Auftrag vom 21.10.2026 umfasst ausdrücklich keinen Store-Build,
kein AAB und keinen Upload. Die APKs dienen nur Emulator-Aufnahmen beziehungsweise
der datenbewahrenden Aktualisierung der vorhandenen Smartphone-Dev-App.

Die Übersetzungen wurden technisch, automatisiert und visuell geprüft.
Eine muttersprachliche Prüfung aller sechs Sprachen hat nicht stattgefunden.
