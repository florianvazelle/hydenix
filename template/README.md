<img align="right" width="75px" alt="NixOS" src="https://github.com/HyDE-Project/HyDE/blob/master/Source/assets/nixos.png?raw=true"/>

# hydenix template flake

This is now your personal NixOS configuration.\
Add packages, customize themes, or even disable hydenix and setup your own wm/de.\
Enjoy the full power of Nix!

Visit the [docs/installation.md](https://florianvazelle.github.io/hydenix/installation.md) to get started.

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
| [`docs/installation.md`](https://florianvazelle.github.io/hydenix/installation.md)       | installation guide and setup instructions |
| [`docs/options.md`](https://florianvazelle.github.io/hydenix/options.md)                 | available module configuration options    |
| [`docs/faq.md`](https://florianvazelle.github.io/hydenix/faq.md)                         | frequently asked questions and solutions  |
| [`docs/troubleshooting.md`](https://florianvazelle.github.io/hydenix/troubleshooting.md) | common issues and fixes                   |
| [`docs/upgrading.md`](https://florianvazelle.github.io/hydenix/upgrading.md)             | how to upgrade your configuration         |
| [`docs/contributing.md`](https://florianvazelle.github.io/hydenix/contributing.md)       | guidelines for contributing               |
| [`docs/community.md`](https://florianvazelle.github.io/hydenix/community.md)             | community configurations and examples     |

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

- To learn more about nix, see [nix resources](https://florianvazelle.github.io/hydenix/faq.md#how-do-i-learn-more-about-nix)
- See [module options](https://florianvazelle.github.io/hydenix/options.md) for configuration
- Check the [faq](https://florianvazelle.github.io/hydenix/faq.md) and [troubleshooting](https://florianvazelle.github.io/hydenix/troubleshooting.md) guides

## Getting help

- [hydenix issues](https://github.com/florianvazelle/hydenix/issues)
- [hydenix discussions](https://github.com/florianvazelle/hydenix/discussions)
- [hyde discord](https://discord.gg/AYbJ9MJez7)
