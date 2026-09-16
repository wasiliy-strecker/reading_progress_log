# Beispielfotos beim Erfassen eines Projektstands

- „Beispiele ansehen“ steht direkt bei den Auswahlbuttons unter „Projektstand
  erfassen“. Eine durchblätterbare Galerie zeigt vier passende Motive: Schal,
  Mütze, Granny Square und Häkelkörbchen mit kurzen Fotohinweisen.
- Vier mit dem integrierten Imagegen-Werkzeug erzeugte Original-PNGs werden
  offline als App-Assets gebündelt. Die Bildprompts stehen in
  `docs/PROJECT_PHOTO_EXAMPLES.md`. Fotos dienen der Dokumentation; Reihe oder
  Runde wird weiterhin manuell eingetragen.
- Die Galerie lässt sich per Wischgeste oder Pfeilen bedienen und per
  Schließen/Android-Zurück verlassen. Sie erstellt keinen Projektstand oder
  Fotoentwurf und bleibt bei großer Schrift im Querformat scrollbar.
- Verifiziert: `flutter pub get`, `dart format lib test`, `flutter analyze`
  ohne Befunde; 47 Tests für Galerie/Assets, manuelle Erfassung, Capture,
  Aktionslayout und App-Navigation bestanden.
- Auf dem verbundenen Android-Gerät alle vier Bilder, Wischen, Weiterblättern
  und Rückkehr zu den Erfassungsbuttons geprüft. Dev-App samt Assets per Hot
  Reload aktualisiert. Direkt testen in der laufenden Sitzung; kein APK-Build
  und keine Neuinstallation, daher kein dauerhaftes APK-Update.
