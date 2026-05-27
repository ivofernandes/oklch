#!/usr/bin/env bash
set -euo pipefail

# Optional: set DEVICE_ID to force a specific device (recommended for iOS).
# Example:
# DEVICE_ID=E3592F85-F0DE-4C34-9C14-AC1CE128052C ./scripts/run_generate_screenshots.sh
DEVICE_ID="${DEVICE_ID:-}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
pushd "${SCRIPT_DIR}/../example" >/dev/null
flutter pub get
OUTPUT_DIR="${SCREENSHOT_OUTPUT_DIR:-screenshots_patrol}"
mkdir -p "${OUTPUT_DIR}"
MARKER_FILE="$(mktemp)"
cleanup_marker() {
  rm -f "${MARKER_FILE}"
}
trap cleanup_marker EXIT

extract_patrol_cli_version() {
  local output
  output="$(patrol --version 2>/dev/null || true)"
  printf '%s\n' "${output}" | sed -nE 's/.*patrol_cli v([0-9]+\.[0-9]+\.[0-9]+).*/\1/p' | head -n 1
}

extract_patrol_pkg_version() {
  local lock_file="pubspec.lock"
  [[ -f "${lock_file}" ]] || return 0
  awk '
    $1 == "patrol:" { in_patrol = 1; next }
    in_patrol && $1 == "version:" {
      gsub(/"/, "", $2)
      print $2
      exit
    }
    in_patrol && /^[^[:space:]]/ { exit }
  ' "${lock_file}"
}

default_patrol_cli_version() {
  case "${1%%.*}" in
    3) echo "3.11.0" ;;
    *) echo "$1" ;;
  esac
}

if [[ -d ios ]]; then
  RUNNER_SCHEME_FILE="ios/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme"
  PATROL_PKG_VERSION="$(extract_patrol_pkg_version)"
  PATROL_PKG_MAJOR="${PATROL_PKG_VERSION%%.*}"
  PATROL_IOS_CLI_VERSION="${PATROL_IOS_CLI_VERSION:-$(default_patrol_cli_version "${PATROL_PKG_VERSION}")}"
  PATROL_CLI_VERSION="$(extract_patrol_cli_version)"
  PATROL_CLI_MAJOR="${PATROL_CLI_VERSION%%.*}"
  if [[ -f "${RUNNER_SCHEME_FILE}" ]] && ! grep -q "RunnerUITests" "${RUNNER_SCHEME_FILE}"; then
    echo "Error: iOS Runner scheme is missing RunnerUITests, which Patrol requires." >&2
    echo "Fix: re-run the AutoTest Patrol boilerplate step so it can add the iOS UI test target." >&2
    exit 2
  fi
  if [[ -n "${PATROL_PKG_MAJOR}" && "${PATROL_CLI_MAJOR}" != "${PATROL_PKG_MAJOR}" ]]; then
    echo "Current patrol_cli (${PATROL_CLI_VERSION:-unknown}) is incompatible with patrol ${PATROL_PKG_VERSION:-unknown}."
    echo "Ensuring compatible patrol_cli version (${PATROL_IOS_CLI_VERSION})..."
    dart pub global activate --overwrite patrol_cli "${PATROL_IOS_CLI_VERSION}" >/dev/null
    hash -r
    PATROL_CLI_VERSION="$(extract_patrol_cli_version)"
    PATROL_CLI_MAJOR="${PATROL_CLI_VERSION%%.*}"
  fi
  if [[ -n "${PATROL_PKG_MAJOR}" && "${PATROL_CLI_MAJOR}" != "${PATROL_PKG_MAJOR}" ]]; then
    echo "Error: patrol_cli is still ${PATROL_CLI_VERSION:-unknown}; expected a ${PATROL_PKG_MAJOR}.x CLI for patrol ${PATROL_PKG_VERSION:-unknown}." >&2
    echo "Please run: dart pub global activate patrol_cli ${PATROL_IOS_CLI_VERSION}" >&2
    exit 2
  fi
fi

PATROL_ARGS=(test --target=integration_test/screenshot_patrol_test_generated_test.dart --verbose)
PATROL_ARGS+=(--dart-define "AUTO_TEST_PATROL_SCREENSHOT_DIR=${PWD}/${OUTPUT_DIR}")
if [[ -n "${DEVICE_ID}" ]]; then
  PATROL_ARGS+=(--device "${DEVICE_ID}")
elif [[ ! -t 0 ]]; then
  echo "Error: multiple-device Patrol runs need DEVICE_ID when stdin is not interactive." >&2
  echo "Hint: DEVICE_ID=<device-id> ./scripts/run_generate_screenshots.sh" >&2
  exit 2
fi

patrol "${PATROL_ARGS[@]}"

copied=0
SEARCH_ROOTS=()
if [[ -n "${DEVICE_ID}" && -d "${HOME}/Library/Developer/CoreSimulator/Devices/${DEVICE_ID}" ]]; then
  SEARCH_ROOTS+=("${HOME}/Library/Developer/CoreSimulator/Devices/${DEVICE_ID}")
else
  SEARCH_ROOTS+=("${HOME}/Library/Developer/CoreSimulator/Devices")
fi
SEARCH_ROOTS+=("${HOME}/Library/Containers")
for root in "${SEARCH_ROOTS[@]}"; do
  [[ -d "${root}" ]] || continue
  while IFS= read -r -d '' file; do
    cp "${file}" "${OUTPUT_DIR}/$(basename "${file}")"
    copied=$((copied + 1))
  done < <(find "${root}" -type f -path "*/auto_test_patrol_screenshots/*" -newer "${MARKER_FILE}" -print0 2>/dev/null || true)
done
if (( copied > 0 )); then
  echo "Collected ${copied} sandboxed Patrol screenshot file(s)."
fi
echo "Screenshot folder contents (${PWD}/${OUTPUT_DIR}):"
ls -lah "${OUTPUT_DIR}"


popd >/dev/null
