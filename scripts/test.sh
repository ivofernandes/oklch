#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

cd "$parent_path"/../packages/oklch_dart
dart test

cd "$parent_path"/../packages/oklch
flutter test
