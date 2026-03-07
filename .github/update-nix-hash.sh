#!/usr/bin/env bash
set -euo pipefail

FILE="$1"
OWNER="$2"
REPO="$3"
REV="$4"

HASH=$(nix-prefetch-url --unpack "https://github.com/$OWNER/$REPO/archive/$REV.tar.gz")

sed -i -E "s|hash = \"sha256-[^\"]+\"|hash = \"$HASH\"|" "$FILE"