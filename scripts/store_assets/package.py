"""Validate and package the real Android captures and code-rendered layouts."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import struct
import subprocess


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


def validate(root, locale="de-DE"):
    copy = json.loads((Path(__file__).parent / "locales" / f"{locale}.json").read_text())
    specs = {
        "icon": (1, (512, 512), 1_000_000),
        "feature": (1, (1024, 500), 15_000_000),
        "phone": (6, (1080, 1920), 8_000_000),
        "tablet7": (4, (1920, 1200), 8_000_000),
        "tablet10": (4, (2560, 1600), 8_000_000),
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
            alt = (copy['heads'][index].replace('\n', ' ') if group == 'phone' else
                   copy['heads'][[0,2,1,5][index]].replace('\n',' ') if group.startswith('tablet') else
                   'Strick & Häkelbuch. ' + copy['tagline'].replace('\n', ' ') if group == 'feature' else
                   'Strick & Häkelbuch')
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
    tree_file = root / "raw/source-tree.sha256"
    return dict(source_tree_sha256=tree_file.read_text().strip() if tree_file.exists() else None,
                source_apk=apk.name, apk_sha256=digest, package=match[1],
                version=f"{match[3]}+{match[2]}",
                source_commit=(root / "raw/source-commit.txt").read_text().strip(),
                source="Current Dev profile build. Real app UI without Dart debug-only controls. Dedicated emulator only")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("output", type=Path)
    parser.add_argument("--apk", type=Path, required=True)
    parser.add_argument("--locale", default="de-DE")
    args = parser.parse_args()
    metadata = source_metadata(args.output, args.apk)
    entries = validate(args.output, args.locale)
    manifest = dict(**metadata, locale=args.locale, assets=entries,
                    captures="Phone 1080x1920 at 360 dpi. Tablet7 1920x1200 at 320 dpi. Tablet10 2560x1600 at 300 dpi.")
    (args.output / "manifest.json").write_text(json.dumps(manifest, ensure_ascii=False, indent=2) + "\n")
    print(f"Validated {len(entries)} upload images for {args.locale}")


if __name__ == "__main__":
    main()
