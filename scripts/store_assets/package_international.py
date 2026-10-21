"""Validate all six listings and 96 assets, then package the store-only handover."""
import argparse
import hashlib
import json
from pathlib import Path
import shutil
import zipfile

from package import source_metadata, validate

LOCALES = ('de-DE', 'en-US', 'es-ES', 'fr-FR', 'it-IT', 'pt-BR')
LIMITS = {'title': 30, 'short-description': 80, 'full-description': 4000, 'release-notes': 500}


def validate_texts(root):
    result = {}
    for field, limit in LIMITS.items():
        text = (root / f'{field}.txt').read_text().strip()
        if not text or len(text) > limit:
            raise ValueError(f'{root.name}/{field}: invalid length {len(text)}')
        if any(line.startswith(('- ', '* ', '# ')) for line in text.splitlines()):
            raise ValueError('Text fields must be directly copyable plain text')
        result[field] = len(text)
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('output', type=Path)
    parser.add_argument('--captures', type=Path, required=True)
    parser.add_argument('--apk', type=Path, required=True)
    args = parser.parse_args()
    root = args.output
    root.mkdir(parents=True, exist_ok=True)
    metadata = source_metadata(args.captures / LOCALES[0], args.apk)
    entries = []
    for locale in LOCALES:
        locale_metadata = source_metadata(args.captures / locale, args.apk)
        folder = root / 'store' / locale
        folder.mkdir(parents=True, exist_ok=True)
        for field in LIMITS:
            shutil.copy2(Path('store-listings') / locale / f'{field}.txt', folder)
        texts = validate_texts(folder)
        assets = validate(folder, locale)
        manifest = dict(locale=locale, text_lengths=texts, assets=assets, **locale_metadata)
        (folder / 'manifest.json').write_text(json.dumps(manifest, ensure_ascii=False, indent=2)+'\n')
        entries.extend(dict(locale=locale, **item) for item in assets)
    assert len(entries) == 96
    shutil.copy2(Path('store-listings/default-language.txt'), root / 'store/default-language.txt')
    manifest = dict(default_store_language='en-US', country_availability_changed=False,
                    upload_performed=False, build_kind='Dev profile capture source only. No Store build.',
                    geometry={'phone':'1080x1920 at 360 dpi','tablet7':'1920x1200 at 320 dpi','tablet10':'2560x1600 at 300 dpi'},
                    demo='Only fictional projects and four existing synthetic photos. Backups imported through the normal app UI.',
                    native_speaker_review=False, assets=entries, **metadata)
    (root / 'store' / 'manifest.json').write_text(json.dumps(manifest, ensure_ascii=False, indent=2)+'\n')
    with zipfile.ZipFile(root / 'strick-haekelbuch-store-international.zip', 'w', zipfile.ZIP_DEFLATED) as archive:
        for path in sorted((root / 'store').rglob('*')):
            if path.is_file() and 'raw' not in path.relative_to(root / 'store').parts:
                archive.write(path, path.relative_to(root))
    print('Validated 6 complete text packs and 96 upload images. Default listing: en-US.')
    print('Store ZIP SHA-256:', hashlib.sha256((root / 'strick-haekelbuch-store-international.zip').read_bytes()).hexdigest())


if __name__ == '__main__':
    main()
