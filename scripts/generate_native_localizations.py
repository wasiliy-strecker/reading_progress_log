#!/usr/bin/env python3
"""Generate the small Android notification catalog from the app's ARB files."""
import argparse
import json
from pathlib import Path
import re
from xml.sax.saxutils import escape

ROOT = Path(__file__).resolve().parents[1]
KEYS = [
    'knitting', 'crochet', 'row', 'round', 'rows', 'rounds', 'noProgressEntriesYet',
    'projectReminders', 'onTimeProjectReminders', 'normalChannelDescription',
    'exactChannelDescription', 'lastProgress', 'reminderBody',
    'testNotificationTitle', 'testNotificationApp', 'testNotificationProject',
    'strickHKelbuchBackup', 'unexpectedError', 'languageSaveFailed',
]
FOLDERS = {'en': 'values', 'de': 'values-de', 'es': 'values-es',
           'fr': 'values-fr', 'it': 'values-it', 'pt': 'values-pt-rBR'}


def resource_name(key):
    return 'l10n_' + re.sub(r'(?<!^)(?=[A-Z])', '_', key).lower()


def outputs():
    template = json.loads((ROOT / 'lib/l10n/app_en.arb').read_text())
    for locale, folder in FOLDERS.items():
        data = json.loads((ROOT / f'lib/l10n/app_{locale}.arb').read_text())
        lines = ['<?xml version="1.0" encoding="utf-8"?>',
                 '<!-- Generated from lib/l10n ARB catalogs. Do not edit. -->', '<resources>']
        for key in KEYS:
            value = data[key]
            placeholders = list(template.get('@' + key, {}).get('placeholders', {}))
            for index, placeholder in enumerate(placeholders, 1):
                value = value.replace('{' + placeholder + '}', f'%{index}$s')
            value = escape(value.replace('\\', '\\\\').replace("'", "\\'").replace('"', '\\"').replace('\n', '\\n'))
            lines.append(f'    <string name="{resource_name(key)}">{value}</string>')
        lines.append('</resources>')
        yield ROOT / f'android/app/src/main/res/{folder}/strings_l10n.xml', '\n'.join(lines) + '\n'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    for path, content in outputs():
        if args.check:
            if not path.exists() or path.read_text() != content:
                raise SystemExit(f'Outdated native localization: {path.relative_to(ROOT)}')
        else:
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text(content)


if __name__ == '__main__':
    main()
