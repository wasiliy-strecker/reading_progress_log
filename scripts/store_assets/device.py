"""Small, emulator-only capture helper. Never accepts a physical-device serial."""
import argparse
import os
from pathlib import Path
import re
import subprocess
import time
import xml.etree.ElementTree as ET


def validate_serial(serial):
    if not re.fullmatch(r"emulator-\d+", serial):
        raise ValueError("Only an explicitly selected emulator is permitted")
    return serial


class Device:
    def __init__(self, serial):
        self.serial = validate_serial(serial)
        self.adb = os.environ.get("SH_ADB", "/home/unknown/.local/android-sdk/platform-tools/adb")
        if self.run("shell", "getprop", "ro.kernel.qemu").strip() != b"1":
            raise ValueError("Target is not an Android emulator")
        name = self.run("emu", "avd", "name").decode().splitlines()[0]
        if not name.startswith("sh_store_assets"):
            raise ValueError("Target must be a dedicated sh_store_assets AVD")

    def run(self, *args):
        return subprocess.check_output([self.adb, "-s", self.serial, *args])

    def nodes(self):
        self.run("shell", "uiautomator", "dump", "/sdcard/sh-store-ui.xml")
        return ET.fromstring(self.run("shell", "cat", "/sdcard/sh-store-ui.xml")).iter("node")

    def tap(self, label):
        matches = [n for n in self.nodes() if any(
            value == label or value.startswith(label + "\n")
            for value in (n.get("text", ""), n.get("content-desc", "")))]
        if not matches:
            raise ValueError(f"Visible UI element not found: {label}")
        a, b, c, d = map(int, re.findall(r"\d+", matches[0].get("bounds")))
        self.run("shell", "input", "tap", str((a+c)//2), str((b+d)//2))
        time.sleep(0.6)

    def visible(self, label):
        return any(value == label or value.startswith(label + "\n")
                   for n in self.nodes()
                   for value in (n.get("text", ""), n.get("content-desc", "")))

    def scroll_to(self, label, width, height):
        for _ in range(15):
            if self.visible(label):
                return
            self.run("shell", "input", "swipe", str(width // 2), str(round(height * .82)),
                     str(width // 2), str(round(height * .28)), "350")
        raise ValueError(f"Cannot scroll to {label}")

    def capture(self, path):
        path = Path(path)
        path.parent.mkdir(parents=True, exist_ok=True)
        time.sleep(1.5)
        path.write_bytes(self.run("exec-out", "screencap", "-p"))
        subprocess.run(["convert", str(path), f"PNG24:{path}"], check=True)

    def text(self, value):
        # Only simple fixture input is accepted, never arbitrary shell syntax.
        if not re.fullmatch(r"[A-Za-z0-9 .,\-]+", value):
            raise ValueError("Use plain ASCII fixture text")
        self.run("shell", "input", "text", value.replace(" ", "%s"))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("serial")
    parser.add_argument("action", choices=["dump", "tap", "capture", "status"])
    parser.add_argument("value", nargs="?")
    args = parser.parse_args()
    device = Device(args.serial)
    if args.action == "status":
        device.run("shell", "settings", "put", "global", "sysui_demo_allowed", "1")
        for extras in [
            ["command", "exit"], ["command", "enter"],
            ["command", "clock", "hhmm", "0941"],
            ["command", "network", "wifi", "show", "level", "4", "fully", "true", "mobile", "hide", "nosim", "hide"],
            ["command", "battery", "level", "100", "plugged", "false"],
            ["command", "notifications", "visible", "false"],
        ]:
            pairs = [part for i in range(0, len(extras), 2)
                     for part in ("-e", extras[i], extras[i+1])]
            device.run("shell", "am", "broadcast", "-a", "com.android.systemui.demo", *pairs)
    elif args.action == "dump":
        for node in device.nodes():
            text = node.get("text") or node.get("content-desc")
            if text:
                print(node.get("bounds"), repr(text))
    elif args.action == "tap":
        device.tap(args.value)
    else:
        device.capture(args.value)


if __name__ == "__main__":
    main()
