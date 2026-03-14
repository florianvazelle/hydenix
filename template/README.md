<img align="right" width="75px" alt="NixOS" src="https://github.com/HyDE-Project/HyDE/blob/master/Source/assets/nixos.png?raw=true"/>

# hydenix template flake

This is now your personal NixOS configuration.\
Add packages, customize themes, or even disable hydenix and setup your own wm/de.\
Enjoy the full power of Nix!

Visit the [Installation](https://florianvazelle.github.io/hydenix/installation.html) to get started.

## File structure

### Core configuration files

| file                         | description                                 |
| ---------------------------- | ------------------------------------------- |
| `flake.nix`                  | main flake configuration and entry point    |
| `configuration.nix`          | nixos system configuration                  |
| `hardware-configuration.nix` | hardware-specific settings (auto-generated) |

### Documentation

| file                                                                                     | purpose                                   |
| ---------------------------------------------------------------------------------------- | ----------------------------------------- |
| [`Installation`](https://florianvazelle.github.io/hydenix/installation.html)       | Installation guide and setup instructions |
| [`Options`](https://florianvazelle.github.io/hydenix/options.html)                 | Available module configuration options    |
| [`FAQ`](https://florianvazelle.github.io/hydenix/faq.html)                         | Frequently asked questions and solutions  |
| [`Troubleshooting`](https://florianvazelle.github.io/hydenix/troubleshooting.html) | Common issues and fixes                   |
| [`Upgrading`](https://florianvazelle.github.io/hydenix/upgrading.html)             | How to upgrade your configuration         |
| [`Contributing`](https://florianvazelle.github.io/hydenix/contributing.html)       | Guidelines for contributing               |
| [`Community`](https://florianvazelle.github.io/hydenix/community.html)             | Community configurations and examples     |

### Write your own modules

> **Note:** Use these directories to override or extend hydenix modules with your custom configurations.

| directory         | type         | purpose                                                               |
| ----------------- | ------------ | --------------------------------------------------------------------- |
| `modules/hm/`     | home manager | custom home-manager module definitions (and for `hydenix.hm` options) |
| `modules/system/` | nixos system | custom system-level module definitions (and for `hydenix` options)    |

### Directory tree

```bash
hydenix/
├── README.md
├── flake.nix
├── configuration.nix
├── hardware-configuration.nix
└── modules/
    ├── hm/default.nix
    └── system/default.nix
```

## Next steps

- To learn more about nix, see [nix resources](https://florianvazelle.github.io/hydenix/faq.html#how-do-i-learn-more-about-nix)
- See [module options](https://florianvazelle.github.io/hydenix/options.html) for configuration
- Check the [faq](https://florianvazelle.github.io/hydenix/faq.html) and [troubleshooting](https://florianvazelle.github.io/hydenix/troubleshooting.html) guides

## Getting help

- [hydenix issues](https://github.com/florianvazelle/hydenix/issues)
- [hydenix discussions](https://github.com/florianvazelle/hydenix/discussions)
- [hyde discord](https://discord.gg/AYbJ9MJez7)
