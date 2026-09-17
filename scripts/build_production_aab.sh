#!/usr/bin/env bash
set -euo pipefail

fail() {
  echo "Error: $*" >&2
  exit 1
}

if [[ $# -ne 0 ]]; then
  fail "No arguments supported. Set the version in pubspec.yaml. This helper always builds store/release."
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
FLUTTER_BIN="${FLUTTER_BIN:-flutter}"
cd "$PROJECT_DIR"

command -v "$FLUTTER_BIN" >/dev/null 2>&1 || fail "Flutter not found. Set FLUTTER_BIN to its executable path."
command -v jq >/dev/null 2>&1 || fail "jq is required to verify Android build metadata."
command -v python3 >/dev/null 2>&1 || fail "Python 3 is required to preserve existing deliveries."

version="$(sed -n 's/^version:[[:space:]]*//p' pubspec.yaml | tr -d '\r')"
if [[ ! "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+(-[0-9A-Za-z.-]+)?\+[1-9][0-9]*$ ]]; then
  fail "pubspec.yaml needs a version such as 1.0.0+1 with an explicit positive build number."
fi
version_name="${version%%+*}"
version_code="${version##*+}"

bundle_dir="$PROJECT_DIR/build/app/outputs/bundle/storeRelease"
source_bundle="$bundle_dir/app-store-release.aab"
# Named deliveries must stay outside Flutter's generated bundle directory.
output_dir="$PROJECT_DIR/build/releases/production"
filename="strick-haekelbuch-${version_name}-build-${version_code}-production.aab"
output="$output_dir/$filename"
if [[ -e "$output" || -L "$output" ]]; then
  fail "Release artifact already exists: $output. Use it for the same release. Increase the build number for a new upload. Nothing was overwritten."
fi

"$FLUTTER_BIN" build appbundle --release --flavor store

metadata="$PROJECT_DIR/build/app/intermediates/merged_manifests/storeRelease/processStoreReleaseManifest/output-metadata.json"
[[ -s "$metadata" ]] || fail "Store release metadata is missing: $metadata"
if ! jq -e --arg name "$version_name" --arg code "$version_code" '
  .applicationId == "com.appfactory.strick_haekelbuch"
  and .variantName == "storeRelease"
  and (.elements | length) == 1
  and .elements[0].versionName == $name
  and (.elements[0].versionCode | tostring) == $code
' "$metadata" >/dev/null; then
  fail "Built package, variant, or version does not match store/release $version. No named artifact was created."
fi
[[ -s "$source_bundle" ]] || fail "Store release AAB is missing or empty: $source_bundle"

mkdir -p "$output_dir"
# Exclusive creation also protects a delivery created after the initial check.
python3 - "$source_bundle" "$output" <<'PY'
from pathlib import Path
import shutil
import sys

source, output = map(Path, sys.argv[1:])
with output.open('xb') as destination, source.open('rb') as bundle:
    shutil.copyfileobj(bundle, destination)
PY
cmp -s "$source_bundle" "$output" || fail "Delivered bytes differ from the generated bundle."

echo "Production AAB: $output"
echo "Version: $version_name (code $version_code), package: com.appfactory.strick_haekelbuch"
echo "Verify the bundle and upload certificate before manual Play Console upload."
