#!/usr/bin/env bash
set -euo pipefail

FILE="$1"
REPO="$2"
REV="$3"

VERSION="${REV#v}"

echo "Updating $FILE -> $REPO $REV"

HASH=$(nix-prefetch-url --unpack "https://github.com/$REPO/archive/$REV.tar.gz")
HASH=$(nix hash to-sri --type sha256 "$HASH")

sed -i -E "s|version = \"[^\"]+\"|version = \"$VERSION\"|" "$FILE"
sed -i -E "s|hash = \"sha256-[^\"]+\"|hash = \"$HASH\"|" "$FILE"