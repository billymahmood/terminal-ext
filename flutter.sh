#!/bin/zsh
##
##  This is a custom Flutter helper functions file for Zsh.
##  Inspired by a request from SuperHumanRoid.
##  Prefix: b_flutter_
##

# -----------------------------------------------------------------------------
# -- Dependencies & Project Management
# -----------------------------------------------------------------------------

## 📦 Get all dependencies listed in pubspec.yaml.
## Usage: b_flutter_get
b_flutter_get() {
  echo "📦 Getting Flutter dependencies..."
  flutter pub get
}

## 🚀 Upgrade all dependencies to their latest compatible versions.
## Usage: b_flutter_upgrade
b_flutter_upgrade() {
  echo "🚀 Upgrading Flutter dependencies..."
  flutter pub upgrade
}

## 🧼 Clean the Flutter build cache.
## Fixes many "weird" build issues.
## Usage: b_flutter_clean
b_flutter_clean() {
  echo "🧼 Cleaning Flutter project..."
  flutter clean
}

## 🩹 Clean the project and then get dependencies.
## The "go-to" command when your project is acting up.
## Usage: b_flutter_fix
b_flutter_fix() {
  b_flutter_clean && b_flutter_get
}

# -----------------------------------------------------------------------------
# -- Code Generation & Analysis
# -----------------------------------------------------------------------------

## ⚙️ Run build_runner to generate files (for Freezed, Riverpod, etc.).
## Includes `--delete-conflicting-outputs`.
## Usage: b_flutter_gen
b_flutter_gen() {
  echo "⚙️  Generating code with build_runner..."
  flutter pub run build_runner build --delete-conflicting-outputs
}

## 🔬 Analyze the project's Dart code for errors and warnings.
## Usage: b_flutter_analyze
b_flutter_analyze() {
  echo "🔬 Analyzing Dart code..."
  flutter analyze
}

## ✅ Run all tests in the project.
## You can pass specific file paths as arguments.
## Usage: b_flutter_test [path/to/test_file.dart]
b_flutter_test() {
  echo "✅ Running Flutter tests..."
  flutter test "$@"
}


# -----------------------------------------------------------------------------
# -- Building & Running
# -----------------------------------------------------------------------------

## ▶️  Run the app on the default device.
## Usage: b_flutter_run
b_flutter_run() {
    echo "▶️  Starting Flutter app..."
    flutter run
}

## 📱 Build a release APK for Android with specific build info and flavor.
## Usage: b_flutter_build_apk <build_name> <build_number>
b_flutter_build_apk() {
  if (( $# < 2 )); then
    echo "Error: Please provide a <build_name> and <build_number>." >&2
    echo "Usage: b_flutter_build_apk 4.1.96 4196" >&2
    return 1
  fi
  echo "📱 Building LIVE release APK -- v$1 ($2)..."
  flutter build apk --release --build-name="$1" --build-number="$2" --dart-define=CONFIG_FLAVOR=live
  echo "✅ APK available in build/app/outputs/flutter-apk/"
}

## 📦 Build a release App Bundle for Android with specific build info and flavor.
## Usage: b_flutter_build_aab <build_name> <build_number>
b_flutter_build_aab() {
  if (( $# < 2 )); then
    echo "Error: Please provide a <build_name> and <build_number>." >&2
    echo "Usage: b_flutter_build_aab 4.1.96 4196" >&2
    return 1
  fi
  echo "📦 Building LIVE release App Bundle -- v$1 ($2)..."
  flutter build appbundle --release --build-name="$1" --build-number="$2" --dart-define=CONFIG_FLAVOR=live
  echo "✅ App Bundle available in build/app/outputs/bundle/release/"
}

## 🍏 Build a release .app for iOS with a specific flavor.
## For running on a physical device via Xcode.
## --- NEWLY ADDED ---
## Usage: b_flutter_build_ios <flavor>
b_flutter_build_ios() {
  if (( $# == 0 )); then
    echo "Error: Please provide a flavor (e.g., staging, live)." >&2
    echo "Usage: b_flutter_build_ios staging" >&2
    return 1
  fi
  local flavor="$1"
  echo "🍏 Building release .app for iOS with '$flavor' flavor..."
  flutter build ios --release --dart-define=CONFIG_FLAVOR="$flavor"
  echo "✅ iOS .app available in build/ios/iphoneos/"
}


## 🍏 Build a release IPA for iOS with a staging flavor.
## For TestFlight/App Store distribution.
## Usage: b_flutter_build_ipa
b_flutter_build_ipa() {
  echo "🍏 Building STAGING release IPA for iOS..."
  flutter build ipa --release --dart-define=CONFIG_FLAVOR=staging
  echo "✅ IPA available in build/ios/archive/"
}


# -----------------------------------------------------------------------------
# -- System Diagnostics
# -----------------------------------------------------------------------------

## 🩺 Check the Flutter environment and see if anything is missing.
## Usage: b_flutter_doctor
b_flutter_doctor() {
  echo "🩺 Running Flutter Doctor..."
  flutter doctor
}