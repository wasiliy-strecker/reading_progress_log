#!/usr/bin/env python3
"""Render the app-local SVG with librsvg (python3-gi, gir1.2-rsvg-2.0, python3-cairo)."""
import json
from pathlib import Path

import cairo
import gi

gi.require_version('Rsvg', '2.0')
from gi.repository import Rsvg

root = Path(__file__).resolve().parent.parent
source = root / 'assets/branding/strick_haekelbuch_icon.svg'
handle = Rsvg.Handle.new_from_file(str(source))
targets = {
    root / 'assets/branding/strick_haekelbuch_icon_1024.png': 1024,
    root / 'web/favicon.png': 32,
}
for density, size in [('mdpi', 48), ('hdpi', 72), ('xhdpi', 96), ('xxhdpi', 144), ('xxxhdpi', 192)]:
    targets[root / f'android/app/src/main/res/mipmap-{density}/ic_launcher.png'] = size
for path in (root / 'web/icons').glob('*.png'):
    targets[path] = 512 if '512' in path.name else 192
icons = root / 'ios/Runner/Assets.xcassets/AppIcon.appiconset'
for item in json.loads((icons / 'Contents.json').read_text())['images']:
    if 'filename' in item:
        targets[icons / item['filename']] = round(float(item['size'].split('x')[0]) * float(item['scale'].rstrip('x')))
for path, size in targets.items():
    surface = cairo.ImageSurface(cairo.FORMAT_ARGB32, size, size)
    viewport = Rsvg.Rectangle()
    viewport.x = viewport.y = 0
    viewport.width = viewport.height = size
    handle.render_document(cairo.Context(surface), viewport)
    surface.write_to_png(str(path))
print(f'Rendered {len(targets)} icon assets.')
