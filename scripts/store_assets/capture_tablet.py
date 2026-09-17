"""Capture the real seeded app at tablet geometry, starting on its home screen."""
import argparse
from pathlib import Path
import subprocess
import time

from device import Device


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("serial")
    parser.add_argument("size", choices=["7", "10"])
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    d = Device(args.serial)
    if not d.visible("Strick & Häkelbuch") or not d.visible("Winterset"):
        raise ValueError("Start on the project overview with the demo restored")
    width, height = (1920, 1080) if args.size == "7" else (2560, 1440)
    density = 240 if args.size == "7" else 288
    d.run("shell", "wm", "size", f"{width}x{height}")
    d.run("shell", "wm", "density", str(density))
    d.run("shell", "cmd", "uimode", "night", "no")
    time.sleep(2)
    subprocess.run(["python3", str(Path(__file__).with_name("device.py")), args.serial, "status"], check=True)
    folder = args.output / f"tablet{args.size}"
    d.capture(folder / "01-dashboard.png")
    d.tap("Einstellungen")
    d.capture(folder / "04-backup.png")
    d.tap("Zurück")
    d.tap("Winterset")
    d.scroll_to("Alle Projektstände anzeigen", width, height)
    d.tap("Alle Projektstände anzeigen")
    d.capture(folder / "02-history.png")
    d.tap("Erfasst am 16.09.2026, 20:00 Uhr")
    # Move the real scroll view just enough to include the row value below the
    # two photos. Keep the complete photos below the fixed app bar.
    start_y = round(height * .75)
    d.run("shell", "input", "swipe", str(width // 2), str(start_y),
          str(width // 2), str(start_y - round(80 * density / 160)), "1000")
    d.capture(folder / "03-reading.png")
    d.tap("Zurück")
    d.tap("Zurück")
    d.tap("Zurück")
    print(f"Captured four {args.size}-inch tablet images", flush=True)


if __name__ == "__main__":
    main()
