"""Validate and package the real Android captures and code-rendered layouts."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import struct
import subprocess
import zipfile

PHONE_ALT = [
    "Projektübersicht mit Winterset, Granny-Decke und Häkelkörbchen sowie ihren aktuellen Reihen- und Rundenständen",
    "Manuelle Eingabe von Reihenstand, Zeitpunkt und Projektnotiz ohne Foto",
    "Neuer Projektstand mit zwei ausgewählten Fotos von Schal und Mütze",
    "Korrekturformular mit mehreren Projektfotos und Funktionen zum Ergänzen und Sortieren",
    "Projektverlauf mit vergangenen Reihenständen, Fortschritten, Fotos und Suchfeld",
    "Projekterinnerung mit täglichem Intervall, Uhrzeit und normaler Benachrichtigung",
    "PDF-Vorschau eines Projektprotokolls mit nummerierten Projektständen sowie Drucken und Teilen",
    "Einstellungen zum Erstellen und Wiederherstellen verschlüsselter Backups",
]
TABLET_ALT = [
    "Projektübersicht auf dem Tablet mit Strick- und Häkelprojekten sowie Reihen- und Rundenständen",
    "Projektverlauf auf dem Tablet mit Reihenständen, Fortschritten und Suchfeld",
    "Gespeicherter Projektstand auf dem Tablet mit mehreren Fotos von Schal und Mütze",
    "Tablet-Einstellungen mit verschlüsselter Datensicherung, Wiederherstellung und Datenschutzhinweisen",
]


def png_info(path, *, icon=False):
    data = path.read_bytes()
    if data[:8] != b"\x89PNG\r\n\x1a\n" or data[12:16] != b"IHDR":
        raise ValueError(f"Not a PNG: {path}")
    width, height, depth, color = struct.unpack(">IIBB", data[16:26])
    if depth != 8 or color != (6 if icon else 2):
        raise ValueError(f"Unexpected PNG bit depth or color mode: {path}")
    subprocess.run(["convert", "-regard-warnings", str(path), "null:"], check=True,
                   stdout=subprocess.DEVNULL, stderr=subprocess.PIPE)
    if icon:
        opaque = subprocess.check_output(["identify", "-format", "%[opaque]", str(path)])
        if opaque.strip().lower() != b"true":
            raise ValueError(f"Icon background must be fully opaque: {path}")
    return width, height, len(data), hashlib.sha256(data).hexdigest()


def validate(root):
    specs = {
        "icon": (1, (512, 512), 1_000_000),
        "feature": (1, (1024, 500), 15_000_000),
        "phone": (8, (1080, 1920), 8_000_000),
        "tablet7": (4, (1920, 1080), 8_000_000),
        "tablet10": (4, (2560, 1440), 8_000_000),
    }
    entries = []
    for group, (count, size, limit) in specs.items():
        paths = sorted((root / group).glob("*.png"))
        if len(paths) != count:
            raise ValueError(f"{group}: expected {count} images, got {len(paths)}")
        for index, path in enumerate(paths):
            width, height, length, digest = png_info(path, icon=group == "icon")
            if (width, height) != size or length > limit:
                raise ValueError(f"Dimensions/size outside specification: {path}")
            alt = (PHONE_ALT[index] if group == "phone" else
                   TABLET_ALT[index] if group.startswith("tablet") else
                   "Strick & Häkelbuch. Dein Handwerk. Dein Fortschritt. Mit einem salbeigrünen Strickprojekt" if group == "feature"
                   else "Strick & Häkelbuch App-Icon mit Wollknäuel, Stricknadel und Häkelnadel")
            if len(alt) > 140:
                raise ValueError("Alt text exceeds 140 characters")
            entries.append(dict(file=str(path.relative_to(root)), width=width,
                                height=height, bytes=length, sha256=digest, alt=alt))
    return entries


def source_metadata(root, apk):
    digest = hashlib.sha256(apk.read_bytes()).hexdigest()
    recorded = (root / "raw/source-apk.sha256").read_text().split()[0]
    if digest != recorded:
        raise ValueError("Source APK differs from the APK used to prepare the emulator")
    badging = (root / "raw/apk-badging.txt").read_text()
    match = re.search(r"package: name='([^']+)' versionCode='([^']+)' versionName='([^']+)'", badging)
    if not match or match[1] != "com.appfactory.strick_haekelbuch.dev":
        raise ValueError("Unexpected source app identity")
    return dict(source_apk=apk.name, apk_sha256=digest, package=match[1],
                version=f"{match[3]}+{match[2]}",
                source_commit=(root / "raw/source-commit.txt").read_text().strip(),
                source="Current Dev profile build. Real app UI without Dart debug-only controls. Dedicated emulator only")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("output", type=Path)
    parser.add_argument("--apk", type=Path, required=True)
    args = parser.parse_args()
    metadata = source_metadata(args.output, args.apk)
    entries = validate(args.output)
    manifest = dict(**metadata,
                    captures="Android API 35. Phone 1080x1920 at 360 dpi. Tablet7 1920x1080 at 240 dpi. Tablet10 2560x1440 at 288 dpi. German, light theme",
                    demo="3 fictional projects, 24 past readings, 21 without photos. Four existing synthetic project photos, two on Winterset. No private data",
                    assets=entries)
    (args.output / "manifest.json").write_text(json.dumps(manifest, ensure_ascii=False, indent=2) + "\n")
    readme = """# Strick & Häkelbuch – Play-Store-Bilder

Die 18 PNG-Dateien sind fertig für den Upload. Das Video-Feld kann leer bleiben.

## In der Play Console zuordnen

| Feld | Ordner / Datei |
| --- | --- |
| App icon | `icon/app-icon.png` |
| Feature graphic | `feature/feature-graphic.png` |
| Phone screenshots | `phone/01.png` bis `08.png`, in dieser Reihenfolge |
| 7-inch tablet screenshots | vier PNGs aus `tablet7`, nach Dateinamen sortiert |
| 10-inch tablet screenshots | vier PNGs aus `tablet10`, nach Dateinamen sortiert |

`VORSCHAU.png` ist nur die Gesamtübersicht. `raw/` enthält Arbeitsmaterial.
Beides gehört nicht in die Screenshot-Felder der Play Console.
Das ZIP enthält die fertigen Bilder, die Vorschau, diese Anleitung und das Manifest.

## Herkunft

Echte Aufnahmen der aktuellen App im eigenen Android-35-Emulator, deutsche Sprache
und helles Erscheinungsbild. Der Dev-Profile-Build enthält keine Dart-Debug-Oberfläche.
Quellstand, Paket, Version und APK-Prüfsumme stehen im Manifest. Die Aufnahme-APK
ist kein Play-Release und wurde nicht auf dem Nutzer-Smartphone installiert.

Die Smartphone-Bilder enthalten vollständige, proportional skalierte Screenshots.
Die Überschriften beanspruchen weniger als 20 Prozent der Bildhöhe. Tablet-Bilder
wurden separat in Tablet-Geometrie aufgenommen und enthalten keine Werbeüberschriften.
Die Android-Statusleiste verwendet den systemeigenen Demomodus mit 09:41 Uhr.

Winterset, Granny-Decke und Häkelkörbchen sowie alle Projektstände sind erfunden.
Die vier synthetischen Fotos stammen aus den vorhandenen App-Beispielen.
Reihen- und Rundenstände werden in der App manuell erfasst. Es gibt keine
automatische Reihenerkennung.
Das Demo-Backup wurde regulär importiert. PDF und Fotobearbeitung wurden in der
echten App ausgeführt. Aufnahmen enthalten keine privaten Nutzerdaten.

Das Icon ist ein PNG32 mit deckendem Hintergrund. Alle übrigen Upload-Bilder
sind PNG24 ohne Transparenz. Maße, Dateigrößen und SHA-256 stehen im Manifest.

## Bildbeschreibungen für die Play Console

"""
    readme += "\n".join(f"{entry['file']}\n{entry['alt']}\n" for entry in entries)
    (args.output / "README.md").write_text(readme)
    archive = args.output / "strick-haekelbuch-play-store-bilder-de.zip"
    with zipfile.ZipFile(archive, "w", zipfile.ZIP_DEFLATED) as result:
        for relative in [e["file"] for e in entries] + ["README.md", "manifest.json", "VORSCHAU.png"]:
            path = args.output / relative
            if not path.is_file():
                raise ValueError(f"Missing delivery file: {path}")
            result.write(path, relative)
    print(f"Validated {len(entries)} upload images. Largest: {max(e['bytes'] for e in entries):,} bytes")
    print(archive)


if __name__ == "__main__":
    main()
