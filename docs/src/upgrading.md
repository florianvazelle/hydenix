# Upgrading

hydenix can be upgraded, downgraded, or version locked easy.
In your template flake folder, update hydenix to main using:

```bash
nix flake update hydenix
```

Or define a specific version in your `flake.nix` template:

```nix
inputs = {
    nixpkgs.follows = "hydenix/nixpkgs";
    hydenix = {
      # Available inputs:
      # Main: github:florianvazelle/hydenix
      # Commit: github:florianvazelle/hydenix/<commit-hash>
      # Version: github:florianvazelle/hydenix/v1.0.0
      url = "github:florianvazelle/hydenix";
    };
  };
```

Run `nix flake update hydenix` again to load the update, then rebuild your system to apply the changes.

## When to upgrade

Starting from your current version (for example v2.3.1) upgrades can come in three flavours:

- a **major** bump, which may introduce breaking changes; always read the release notes for API‑level changes before moving to a new major version,
- a **minor** bump, which brings new features and is generally safe to apply, and
- a **patch** bump, which contains bug fixes and is likewise safe to update.

In other words, inspect major releases carefully, and you can routinely pull in minor and patch releases without worry.

> [!Important]
>
> - **Always review [release notes](https://github.com/florianvazelle/hydenix/releases) for major updates (API changes)**
> - Update to minor versions for new features
> - Keep up with patches for stability
