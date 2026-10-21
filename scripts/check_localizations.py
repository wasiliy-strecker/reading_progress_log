#!/usr/bin/env python3
"""Validate complete ARB catalogs and their generated Android subset."""
import json
from pathlib import Path
import re
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]
LOCALES = ('en', 'de', 'es', 'fr', 'it', 'pt')


def validate():
    catalogs = {locale: json.loads((ROOT / f'lib/l10n/app_{locale}.arb').read_text()) for locale in LOCALES}
    keys = {key for key in catalogs['en'] if not key.startswith('@')}
    errors = []
    for locale, catalog in catalogs.items():
        actual = {key for key in catalog if not key.startswith('@')}
        if actual != keys:
            errors.append(f'{locale}: missing={sorted(keys-actual)}, extra={sorted(actual-keys)}')
        for key in keys & actual:
            value = catalog[key]
            if not isinstance(value, str) or not value.strip():
                errors.append(f'{locale}/{key}: empty message')
            if ';' in value:
                errors.append(f'{locale}/{key}: semicolon in user-facing text')
            placeholders = set(catalogs['en'].get('@' + key, {}).get('placeholders', {}))
            for placeholder in placeholders:
                if not re.search(r'\{' + re.escape(placeholder) + r'[,}]', value):
                    errors.append(f'{locale}/{key}: missing placeholder {placeholder}')
            if ', plural,' in catalogs['en'][key] and ', plural,' not in value:
                errors.append(f'{locale}/{key}: missing plural rule')
    actual_files = {p.stem for p in (ROOT / 'lib/l10n').glob('app_*.arb')}
    if actual_files != {f'app_{locale}' for locale in LOCALES}:
        errors.append('Unexpected application translation locale')
    if errors:
        raise ValueError('\n'.join(errors))
    subprocess.run([sys.executable, str(ROOT / 'scripts/generate_native_localizations.py'), '--check'], check=True)
    print(f'Validated {len(keys)} messages in all six languages and the Android notification resources.')


if __name__ == '__main__':
    validate()
