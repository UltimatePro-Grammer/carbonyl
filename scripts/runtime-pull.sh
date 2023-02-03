#!/usr/bin/env bash

export CARBONYL_ROOT=$(cd $(dirname -- "$0") && dirname -- $(pwd))

cd "$CARBONYL_ROOT"
source "scripts/env.sh"

echo "Computing Chromium patches sha.."

sha=$(scripts/runtime-hash.sh)

triple=$(scripts/platform-triple.sh "$2")
url="https://carbonyl.fathy.fr/runtime/$sha/$triple.tgz"

echo "Downloading pre-build binaries from $url"

mkdir -p build/pre-built

if ! curl --silent --fail --output "build/pre-built/$triple.tgz" "$url"; then
    echo "Pre-built binaries not available"

    exit 1
else
    echo "Pre-build binaries available"
fi
