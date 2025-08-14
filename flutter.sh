#!/bin/zsh
##
##  Custom Flutter helper functions for Zsh.
##  Prefix: b_f_
##

# -----------------------------------------------------------------------------
# -- Dependencies & Project Management
# -----------------------------------------------------------------------------

## 📦 Get all dependencies listed in pubspec.yaml.
b_f_get() {
  echo "📦 Getting Flutter dependencies..."
  flutter pub get
}

## 🚀 Upgrade all dependencies to their latest compatible versions.
b_f_upgrade() {
  echo "🚀 Upgrading Flutter dependencies..."
  flutter pub upgrade
}

## 🧼 Clean the Flutter build cache.
b_f_clean() {
  echo "🧼 Cleaning Flutter project..."
  flutter clean
}

## 🩹 Clean the project and then get dependencies.
b_f_fix() {
  b_f_clean && b_f_get
}

# -----------------------------------------------------------------------------
# -- Code Generation & Analysis
# -----------------------------------------------------------------------------

## ⚙️ Run build_runner to generate files.
b_f_gen() {
  echo "⚙️  Generating code with build_runner..."
  flutter pub run build_runner build --delete-conflicting-outputs
}

## 🔬 Analyze the project's Dart code.
b_f_analyze() {
  echo "🔬 Analyzing Dart code..."
  flutter analyze
}

## ✅ Run all tests in the project.
b_f_test() {
  echo "✅ Running Flutter tests..."
  flutter test "$@"
}

## --- NEW ---
## 📊 Run tests and generate a code coverage report.
b_f_test_cov() {
    echo "📊 Running tests with coverage..."
    flutter test --coverage
    # Check if lcov is installed for generating the report
    if command -v lcov &> /dev/null && [ -d "coverage" ]; then
        echo "✨ Generating HTML coverage report..."
        # Note: genhtml may not be available on all systems with lcov
        genhtml coverage/lcov.info -o coverage/html
        echo "✅ Report available at coverage/html/index.html"
    fi
}

# -----------------------------------------------------------------------------
# -- Building & Running
# -----------------------------------------------------------------------------

## --- NEW ---
## 📱 List all available devices and emulators.
b_f_devices() {
    echo "📱 Listing available devices..."
    flutter devices
}

## ▶️  Run the app on the default device.
b_f_run() {
    echo "▶️  Starting Flutter app..."
    flutter run
}

## --- NEW ---
## 🎯 Run the app on a specific device by ID.
b_f_run_d() {
    if (( $# == 0 )); then
        echo "Error: Please provide a device ID." >&2
        echo "Run 'b f_devices' to see a list of available IDs." >&2
        return 1
    fi
    echo "🎯 Starting Flutter app on device '$1'..."
    flutter run -d "$1"
}

## 📱 Build a release APK for Android.
b_f_build_apk() {
  if (( $# < 2 )); then
    echo "Error: Please provide a <build_name> and <build_number>." >&2
    echo "Usage: b f_build_apk 4.1.96 4196" >&2
    return 1
  fi
  echo "📱 Building LIVE release APK -- v$1 ($2)..."
  flutter build apk --release --build-name="$1" --build-number="$2" --dart-define=CONFIG_FLAVOR=live
  echo "✅ APK available in build/app/outputs/flutter-apk/"
}

## 📦 Build a release App Bundle for Android.
b_f_build_aab() {
  if (( $# < 2 )); then
    echo "Error: Please provide a <build_name> and <build_number>." >&2
    echo "Usage: b f_build_aab 4.1.96 4196" >&2
    return 1
  fi
  echo "📦 Building LIVE release App Bundle -- v$1 ($2)..."
  flutter build appbundle --release --build-name="$1" --build-number="$2" --dart-define=CONFIG_FLAVOR=live
  echo "✅ App Bundle available in build/app/outputs/bundle/release/"
}

## 🍏 Build a release .app for iOS with a specific flavor.
b_f_build_ios() {
  if (( $# == 0 )); then
    echo "Error: Please provide a flavor (e.g., staging, live)." >&2
    echo "Usage: b f_build_ios staging" >&2
    return 1
  fi
  local flavor="$1"
  echo "🍏 Building release .app for iOS with '$flavor' flavor..."
  flutter build ios --release --dart-define=CONFIG_FLAVOR="$flavor"
  echo "✅ iOS .app available in build/ios/iphoneos/"
}

## 🍏 Build a release IPA for iOS.
b_f_build_ipa() {
  echo "🍏 Building STAGING release IPA for iOS..."
  flutter build ipa --release --dart-define=CONFIG_FLAVOR=staging
  echo "✅ IPA available in build/ios/archive/"
}

# -----------------------------------------------------------------------------
# -- Development Tools & System
# -----------------------------------------------------------------------------

## --- NEW ---
## 🛠️ Open Flutter DevTools in your default browser.
## Assumes the default port is running.
b_f_devtools() {
    local devtools_url="http://127.0.0.1:9100"
    echo "🛠️ Opening Flutter DevTools at $devtools_url..."
    # 'open' is for macOS, 'xdg-open' is for Linux
    open "$devtools_url" 2>/dev/null || xdg-open "$devtools_url" 2>/dev/null
}

## 🩺 Check the Flutter environment and see if anything is missing.
b_f_doctor() {
  echo "🩺 Running Flutter Doctor..."
  flutter doctor
}

## --- NEW ---
## 🔼 Upgrade the Flutter SDK to the latest version.
b_f_sdk_upgrade() {
    echo "🔼 Upgrading Flutter SDK..."
    flutter upgrade
}