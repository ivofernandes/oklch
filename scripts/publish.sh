#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

cd "$parent_path/../packages/oklch_dart"
dart format .
dart pub publish

cd "$parent_path/../packages/oklch"
dart format .
dart pub publish