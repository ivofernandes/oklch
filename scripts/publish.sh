#!/bin/bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"

# Resolve the Flutter-aware workspace before running either test suite.
cd "$ROOT"
flutter pub get

# Check both packages before starting the irreversible publication process.
cd "$ROOT/packages/oklch_dart"
dart format --output=none --set-exit-if-changed lib test
dart test

cd "$ROOT/packages/oklch"
dart format --output=none --set-exit-if-changed lib test
flutter test

# The Dart dependency must be published before the Flutter wrapper.
cd "$ROOT/packages/oklch_dart"
dart pub publish

cd "$ROOT/packages/oklch"
dart pub publish
