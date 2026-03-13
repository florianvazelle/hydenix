#!/usr/bin/env bash

# Exit on error
set -e

# Verify environment variables are set
if [ -z "$HYDE_PINNED" ] || [ -z "$HYDE_MASTER" ]; then
    echo "Error: HYDE_PINNED or HYDE_MASTER environment variables not set"
    exit 1
fi

# Use current directory for output
DIFF_OUTPUT_DIR="./.hyde-cache"

# Create diffs directory if it doesn't exist
mkdir -p "$DIFF_OUTPUT_DIR"

# Function to generate file list
generate_file_list() {
    local dir="$1"
    local output_file="$2"
    
    # Store current directory
    local original_dir
    original_dir=$(pwd)
    
    # Generate list of all files relative to the directory
    cd "$dir"
    find . -type f | sort > "$original_dir/$output_file"
    cd "$original_dir"
}

# Function to compare package lists
compare_package_lists() {
    local base_dir="$1"
    local compare_dir="$2"
    local exit_status=0

    echo "Comparing package lists..."
    
    # Compare core packages
    echo "=== Core Packages Differences ==="
    if ! diff -u --minimal "$base_dir/Scripts/pkg_core.lst" "$compare_dir/Scripts/pkg_core.lst"; then
        echo "WARNING: Core package lists differ"
        exit_status=1
    fi

    echo -e "\n=== Extra Packages Differences ==="
    if ! diff -u --minimal "$base_dir/Scripts/pkg_extra.lst" "$compare_dir/Scripts/pkg_extra.lst"; then
        echo "WARNING: Extra package lists differ"
        exit_status=1
    fi

    # Save combined diff to file with more concise output
    {
        echo "=== Package List Changes ==="
        echo "Core Packages:"
        diff "$base_dir/Scripts/pkg_core.lst" "$compare_dir/Scripts/pkg_core.lst" || true
        echo -e "\nExtra Packages:"
        diff "$base_dir/Scripts/pkg_extra.lst" "$compare_dir/Scripts/pkg_extra.lst" || true
    } > "$DIFF_OUTPUT_DIR/package_lists.diff"

    return $exit_status
}

# Main execution
echo "Generating file lists and comparing..."

# Generate file lists
PINNED_LIST="$DIFF_OUTPUT_DIR/pinned_files.txt"
MASTER_LIST="$DIFF_OUTPUT_DIR/master_files.txt"
COMBINED_DIFF="$DIFF_OUTPUT_DIR/combined_changes.diff"

generate_file_list "$HYDE_PINNED" "$PINNED_LIST"
generate_file_list "$HYDE_MASTER" "$MASTER_LIST"

# Create combined diff file
{
    echo "=== File Structure Changes ==="
    echo "Comparing $HYDE_PINNED with $HYDE_MASTER"
    echo "----------------------------------------"
    diff "$PINNED_LIST" "$MASTER_LIST" 2>&1 || true
    
    echo -e "\n=== Package List Changes ==="
    echo "Core Packages:"
    diff "$HYDE_PINNED/Scripts/pkg_core.lst" "$HYDE_MASTER/Scripts/pkg_core.lst" || true
    echo -e "\nExtra Packages:"
    diff "$HYDE_PINNED/Scripts/pkg_extra.lst" "$HYDE_MASTER/Scripts/pkg_extra.lst" || true
    
    echo -e "\n=== Restore.psv Differences ==="
    diff "$HYDE_PINNED/Scripts/restore_cfg.psv" "$HYDE_MASTER/Scripts/restore_cfg.psv" || true
} > "$COMBINED_DIFF"

# Clean up individual files
rm -f "$PINNED_LIST" "$MASTER_LIST"
rm -f "$DIFF_OUTPUT_DIR/file_structure.diff"
rm -f "$DIFF_OUTPUT_DIR/package_lists.diff"

echo "Comparison complete. Combined diff has been saved to $COMBINED_DIFF"