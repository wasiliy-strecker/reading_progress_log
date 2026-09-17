"""Exercise release delivery guards without Flutter builds or signing keys."""
import json
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


class ProductionReleaseTest(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="sh-release-test-")
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        scripts = self.root / "scripts"
        scripts.mkdir()
        self.script = scripts / "build_production_aab.sh"
        shutil.copyfile(Path(__file__).with_name(self.script.name), self.script)
        (self.root / "pubspec.yaml").write_text("version: 1.0.0+1\n")
        self.metadata = {
            "applicationId": "com.appfactory.strick_haekelbuch",
            "variantName": "storeRelease",
            "elements": [{"versionName": "1.0.0", "versionCode": 1}],
        }
        self.fixture = self.root / "metadata-fixture.json"
        self.fixture.write_text(json.dumps(self.metadata))
        self.fake_flutter = self.root / "flutter"
        self.fake_flutter.write_text("""#!/usr/bin/env python3
from pathlib import Path
import os
import sys
Path('flutter-arguments.txt').write_text(' '.join(sys.argv[1:]))
if os.environ.get('FAIL_BUILD'):
    sys.exit(1)
bundle = Path('build/app/outputs/bundle/storeRelease/app-store-release.aab')
bundle.parent.mkdir(parents=True, exist_ok=True)
bundle.write_bytes(b'new release fixture')
metadata = Path('build/app/intermediates/merged_manifests/storeRelease/processStoreReleaseManifest/output-metadata.json')
metadata.parent.mkdir(parents=True, exist_ok=True)
metadata.write_bytes(Path('metadata-fixture.json').read_bytes())
""")
        self.fake_flutter.chmod(0o700)
        self.env = dict(os.environ, FLUTTER_BIN=str(self.fake_flutter))
        self.output = self.root / "build/releases/production/strick-haekelbuch-1.0.0-build-1-production.aab"

    def run_helper(self, *args):
        return subprocess.run(["bash", str(self.script), *args], cwd=self.root,
                              env=self.env, capture_output=True, text=True)

    def test_builds_store_release_and_delivers_matching_bytes(self):
        result = self.run_helper()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(self.output.read_bytes(), b"new release fixture")
        self.assertEqual((self.root / "flutter-arguments.txt").read_text(),
                         "build appbundle --release --flavor store")

    def test_existing_delivery_is_preserved_without_build(self):
        self.output.parent.mkdir(parents=True)
        self.output.write_bytes(b"already delivered")
        self.assertNotEqual(self.run_helper().returncode, 0)
        self.assertEqual(self.output.read_bytes(), b"already delivered")
        self.assertFalse((self.root / "flutter-arguments.txt").exists())

    def test_failed_build_does_not_deliver_stale_bundle(self):
        old = self.root / "build/app/outputs/bundle/storeRelease/app-store-release.aab"
        old.parent.mkdir(parents=True)
        old.write_bytes(b"stale bundle")
        self.env["FAIL_BUILD"] = "1"
        self.assertNotEqual(self.run_helper().returncode, 0)
        self.assertFalse(self.output.exists())

    def test_wrong_identity_or_version_is_not_delivered(self):
        for field, value in [("applicationId", "com.example.other"),
                             ("variantName", "devRelease"),
                             ("elements", [{"versionName": "1.0.0", "versionCode": 2}])]:
            with self.subTest(field=field):
                self.fixture.write_text(json.dumps(dict(self.metadata, **{field: value})))
                self.assertNotEqual(self.run_helper().returncode, 0)
                self.assertFalse(self.output.exists())

    def test_invalid_version_or_extra_arguments_do_not_build(self):
        self.assertNotEqual(self.run_helper("--debug").returncode, 0)
        (self.root / "pubspec.yaml").write_text("version: 1.0.0\n")
        self.assertNotEqual(self.run_helper().returncode, 0)
        self.assertFalse((self.root / "flutter-arguments.txt").exists())


if __name__ == "__main__":
    unittest.main()
