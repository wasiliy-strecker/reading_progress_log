import importlib.util
import hashlib
from pathlib import Path
import subprocess
from unittest.mock import patch
import tempfile
import unittest


def module(name):
    spec = importlib.util.spec_from_file_location(name, Path(__file__).with_name(name + ".py"))
    result = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(result)
    return result


device = module("device")
package = module("package")


class StoreToolsTest(unittest.TestCase):
    def test_physical_device_and_implicit_target_rejected(self):
        for value in ["PHYSICAL123", "", "emulator-5580;echo", "localhost:5555"]:
            with self.assertRaises(ValueError):
                device.validate_serial(value)
        self.assertEqual(device.validate_serial("emulator-5580"), "emulator-5580")

    def test_foreign_emulator_rejected(self):
        for replies in [[b"0"], [b"1", b"pixel_tablet_api35\nOK"]]:
            with patch.object(device.Device, "run", side_effect=replies):
                with self.assertRaises(ValueError):
                    device.Device("emulator-5580")

    def test_png_format_and_truncation_rejected(self):
        with tempfile.TemporaryDirectory(prefix="sh-png-test-") as folder:
            path = Path(folder) / "image.png"
            for encoding, is_icon in [("PNG24", False), ("PNG32", True)]:
                subprocess.run(["convert", "-size", "8x8", "xc:white",
                                f"{encoding}:{path}"], check=True)
                self.assertEqual(package.png_info(path, icon=is_icon)[:2], (8, 8))
                with self.assertRaises(ValueError):
                    package.png_info(path, icon=not is_icon)
            path.write_bytes(path.read_bytes()[:33])
            with self.assertRaises(subprocess.CalledProcessError):
                package.png_info(path, icon=True)
            subprocess.run(["convert", "-size", "8x8", "xc:none",
                            f"PNG32:{path}"], check=True)
            with self.assertRaises(ValueError):
                package.png_info(path, icon=True)

    def test_missing_assets_rejected(self):
        with tempfile.TemporaryDirectory(prefix="sh-package-test-") as folder:
            with self.assertRaises(ValueError):
                package.validate(Path(folder))

    def test_alt_text_limits(self):
        self.assertTrue(all(0 < len(text) <= 140 for text in package.PHONE_ALT + package.TABLET_ALT))

    def test_source_identity_and_apk_hash_must_match_capture(self):
        with tempfile.TemporaryDirectory(prefix="sh-source-test-") as folder:
            root = Path(folder)
            (root / "raw").mkdir()
            apk = root / "fixture.apk"
            apk.write_bytes(b"fixture APK")
            (root / "raw/source-apk.sha256").write_text(hashlib.sha256(apk.read_bytes()).hexdigest())
            (root / "raw/source-commit.txt").write_text("fixture-commit")
            badging = root / "raw/apk-badging.txt"
            badging.write_text("package: name='com.appfactory.strick_haekelbuch.dev' versionCode='1' versionName='1.0.0'")
            self.assertEqual(package.source_metadata(root, apk)["version"], "1.0.0+1")
            badging.write_text("package: name='com.example.other' versionCode='1' versionName='1.0.0'")
            with self.assertRaises(ValueError):
                package.source_metadata(root, apk)
            apk.write_bytes(b"different APK")
            with self.assertRaises(ValueError):
                package.source_metadata(root, apk)


if __name__ == "__main__":
    unittest.main()
