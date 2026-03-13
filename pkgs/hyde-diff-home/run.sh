#!/usr/bin/env bash

# Exit on error
set -e

export LC_ALL=C
export LANG=C

# Verify environment variable is set
if [ -z "$HYDE_PINNED" ]; then
    echo "Error: HYDE_PINNED environment variable not set"
    exit 1
fi

HYDE_SRC="$HYDE_PINNED/Configs"
BUILD_DIR="$(mktemp -d)"

echo "Building Home Manager configuration..."

# build home-manager activation package
nix build .#homeConfigurations.default.activationPackage --out-link "$BUILD_DIR/result"

HOME_FILES="$BUILD_DIR/result/home-files"

if [ ! -d "$HOME_FILES" ]; then
  echo "Could not find built home-files directory"
  exit 1
fi

echo
echo "Comparing Hyde repo with generated Home Manager files"
echo

# capture diff output
DIFF_OUTPUT=$(diff -qr -w "$HYDE_SRC" "$HOME_FILES" || true)

# Function to normalize paths relative to $HOME
normalize_paths() {
    local entries=("$@")   # Accepts a list of entries as arguments

    for entry in "${entries[@]}"; do
        # Remove everything before the colon and space
        local path="${entry//: /\/}"

        # Prepend $HOME for relative or absolute-like entries
        local normalized="./$path"

        # Remove double slashes
        normalized="${normalized//\/\//\/}"

        echo "$normalized"
    done
}

# prepare arrays
only_in_hyde=()
only_in_home=()
differ=()

while IFS= read -r line; do
    if [[ $line == "Only in $HYDE_SRC"* ]]; then
        path=$(normalize_paths "${line#"Only in ${HYDE_SRC}"}")
        only_in_hyde+=("$path")
    elif [[ $line == "Only in $HOME_FILES"* ]]; then
        path=$(normalize_paths "${line#"Only in ${HOME_FILES}"}")
        only_in_home+=("$path")
    elif [[ $line == Files* && $line == *differ ]]; then
        file=$(echo "$line" | awk '{print $2}')
        path=$(normalize_paths "${file#"${HYDE_SRC}"}")
        differ+=("$path")
    fi
done <<< "$DIFF_OUTPUT"

# print categorized output
echo "=== Files present in Hyde repo but NOT installed by Home Manager ==="
printf "%s\n" "${only_in_hyde[@]}"

echo -e "\n=== Files present in Home Manager but NOT in Hyde repo ==="
printf "%s\n" "${only_in_home[@]}"

echo -e "\n=== Files that differ ==="
printf "%s\n" "${differ[@]}"

echo
echo "Files present in Hyde but NOT installed by Home Manager:"
echo

cd "$HYDE_SRC" && find . ! -type d | sort > "$BUILD_DIR/hyde_files.lst"
cd "$HOME_FILES" && find . ! -type d | sort > "$BUILD_DIR/home_files.lst"

comm -23 "$BUILD_DIR/hyde_files.lst" "$BUILD_DIR/home_files.lst"

echo
echo "Done."