# Dev-App auf dem Smartphone installieren

- Vorhandenes, bereits geprüftes Dev-APK auf dem verbundenen Android-Smartphone
  BVL-N49 installiert: **Strick & Häkelbuch Dev**, Version **1.0.0 (1)**,
  Paket `com.appfactory.strick_haekelbuch.dev`.
- Vorab geprüft: Zielpaket nicht installiert, daher keine vorhandene Version,
  kein Debug-Flag und kein Installer am Gerät. APK-Identität, Debug-Flag und
  gültige Android-Debug-Signatur geprüft.
- Installation mit `adb -s <device-id> install -r -t -g --no-streaming
  build/app/outputs/flutter-apk/app-dev-debug.apk`: **Success**.
- Hauptaktivität mit `adb shell am start -W -n
  com.appfactory.strick_haekelbuch.dev/com.appfactory.strick_haekelbuch.MainActivity`
  gestartet: **Status: ok**. Laufender Prozess und aktive Vordergrundaktivität
  bestätigt; installierte Version 1.0.0 (1), `DEBUGGABLE`, Installer `null`,
  initiierendes Paket `com.android.shell` verifiziert.
- Keine Deinstallation oder Datenlöschung. Kein neuer Build und keine
  Quellcodeänderung; Kamera, Export und Erinnerungen in diesem Schritt nicht
  am Gerät getestet. Dokumentationsänderung auf Inhalt und Whitespace geprüft.
