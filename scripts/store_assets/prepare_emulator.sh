#!/usr/bin/env bash
# Install a supplied Dev profile APK only in a new, isolated capture emulator.
set -euo pipefail
if [[ $# -ne 2 ]]; then
  echo 'Usage: bash scripts/store_assets/prepare_emulator.sh PROFILE.apk OUTPUT' >&2
  exit 2
fi
apk=$(realpath "$1")
mkdir -p "$2/raw"
output=$(realpath "$2")
sdk=${SH_ANDROID_SDK:-/home/unknown/.local/android-sdk}
adb=${SH_ADB:-$sdk/platform-tools/adb}
port=${SH_EMULATOR_PORT:-5580}
if ! [[ "$port" =~ ^[0-9]+$ ]] || (( port < 5554 || port > 5682 || port % 2 )); then
  echo 'Use a free even emulator port between 5554 and 5682.' >&2
  exit 2
fi
serial="emulator-$port"
if "$adb" devices | awk '{print $1}' | rg -qx "$serial"; then
  echo 'Refusing to reuse an existing emulator.' >&2
  exit 1
fi
aapt="$sdk/build-tools/36.0.0/aapt"
"$aapt" dump badging "$apk" > "$output/raw/apk-badging.txt"
rg -q "package: name='com.appfactory.strick_haekelbuch.dev'" "$output/raw/apk-badging.txt"
"$aapt" dump xmltree "$apk" AndroidManifest.xml > "$output/raw/apk-manifest.txt"
# Profile inherits Android's debug signing/configuration but uses AOT Dart code.
# A debug APK's kernel assets would expose Dart-only development UI.
unzip -Z1 "$apk" > "$output/raw/apk-entries.txt"
if ! rg -q '^lib/x86_64/libapp.so$' "$output/raw/apk-entries.txt" || \
   rg -q 'flutter_assets/kernel_blob.bin$' "$output/raw/apk-entries.txt"; then
  echo 'Use the x86_64 Dev profile APK with AOT Dart code.' >&2
  exit 1
fi
sha256sum "$apk" > "$output/raw/source-apk.sha256"
git rev-parse HEAD > "$output/raw/source-commit.txt"
python3 scripts/store_assets/source_fingerprint.py > "$output/raw/source-tree.sha256"
git status --short > "$output/raw/source-status.txt"
work=$(mktemp -d /dev/shm/sh-store-assets-XXXXXX)
name="sh_store_assets_$(date +%s)"
printf '%s\n' "$name" > "$work/avd-name"
printf '%s\n' "$work" > "$output/raw/emulator-workspace.txt"
mkdir -p "$work/avd"
export ANDROID_AVD_HOME="$work/avd"
export ANDROID_SDK_ROOT="$sdk"
printf 'no\n' | "$sdk/cmdline-tools/latest/bin/avdmanager" create avd \
  --name "$name" --package 'system-images;android-35;google_apis;x86_64' \
  --path "$work/avd/$name.avd" --device pixel_6
"$sdk/emulator/emulator" -avd "$name" -port "$port" -no-window \
  -no-audio -no-snapshot -no-boot-anim -gpu swiftshader_indirect \
  -memory 3072 -cores 2 -camera-back none -camera-front none \
  >"$work/emulator.log" 2>&1 </dev/null &
emulator_pid=$!
for attempt in $(seq 1 600); do
  if [[ $("$adb" -s "$serial" shell getprop sys.boot_completed 2>/dev/null | tr -d '\r') == 1 ]]; then
    break
  fi
  sleep 1
done
[[ $("$adb" -s "$serial" shell getprop sys.boot_completed | tr -d '\r') == 1 ]]
[[ $("$adb" -s "$serial" shell getprop ro.kernel.qemu | tr -d '\r') == 1 ]]
[[ $("$adb" -s "$serial" emu avd name | head -n1 | tr -d '\r') == "$name" ]]
if [[ -n $("$adb" -s "$serial" shell pm list packages -i com.appfactory.strick_haekelbuch.dev) ]]; then
  echo 'Unexpected existing app. Refusing installation.' >&2
  exit 1
fi
"$adb" -s "$serial" install -r -t --no-streaming "$apk"
"$adb" -s "$serial" shell dumpsys package com.appfactory.strick_haekelbuch.dev > "$output/raw/installed-package.txt"
rg 'versionCode=|versionName=|flags=|installerPackageName=' "$output/raw/installed-package.txt"
printf 'Isolated workspace: %s\nEmulator serial: %s\n' "$work" "$serial"
wait "$emulator_pid"
