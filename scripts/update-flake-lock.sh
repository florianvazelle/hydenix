#!/usr/bin/env bash

set -eo pipefail

echo "Update nixpkgs input to unstable"
sed -i 's|nixpkgs.url = "github:nixos/nixpkgs/.*"|nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"|' flake.nix
      
echo "Update flake.lock"
nix flake update
      
echo "Update flake.nix with new rev"
NODE_ALIAS=$(jq -r '.nodes."root".inputs.nixpkgs' flake.lock)
NEW_REV=$(jq -r ".nodes.${NODE_ALIAS}.locked.rev" flake.lock)
if [ -n "$NEW_REV" ] && [ "$NEW_REV" != "null" ]; then
    sed -i 's|nixpkgs.url = "github:nixos/nixpkgs/[^"]*"|nixpkgs.url = "github:nixos/nixpkgs/'$NEW_REV'"|' flake.nix
else
    echo "Failed to extract revision from flake.lock"
    exit 1
fi

echo "Verify flake.nix"
grep -q "nixpkgs.url" flake.nix || (echo "Failed to update flake.nix" && exit 1)