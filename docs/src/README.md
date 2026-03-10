# Introduction

**hydenix** is a **NixOS + Home Manager configuration** for [HyDE](https://github.com/HyDE-Project/HyDE).

It brings the HyDE desktop experience to NixOS while taking advantage of
the Nix module system and reproducible configuration management.

## Features

- Declarative configuration via `hydenix` and `hydenix.hm` options
- Built on the **NixOS module system** (easily extend, override, or disable modules)
- Close feature parity with the upstream [HyDE](https://github.com/HyDE-Project/HyDE)
- Support for all community themes from [hyde-gallery](https://github.com/HyDE-Project/hyde-gallery)
- Fully reproducible desktop environments
- Easy system rollbacks
- Version-controlled desktop configuration

## Requirements

- A **minimal NixOS installation**

Follow the official instructions from the [NixOS installation ISO](https://nixos.org/download/#nixos-iso).

> [!IMPORTANT]  
> Some familiarity with **functional programming concepts** is recommended.  
>
> If you are new to Nix, check the [Nix resources](./faq.md#how-do-i-learn-more-about-nix) or ask questions in **Discussions** or **Discord**.

## Documentation

- [Installation](./installation.md)
- [Upgrading](./upgrading.md)
- [Module Options](./options.md)
- [FAQ](./faq.md)
- [Troubleshooting & Issues](./troubleshooting.md)
- [Contributing](./contributing.md)
- [Community Configurations](./community.md)
<!-- - [Roadmap / Upcoming Features](./TODO.md) -->

## hydenix VM

If your system supports virtualization, you can try **hydenix in a NixOS VM** without installing it on your machine.

If you encounter issues running Hyprland inside the VM, see the [VirtIO guide](./faq.md#how-do-i-run-hyprland-in-a-vm).

```bash
# run the flake remotely
nix run github:florianvazelle/hydenix
```

> [!NOTE]
> Any configuration changes require rebuilding the VM.
> To reset it, delete the disk image:
>
```text
> rm hydenix.qcow2
> ```
```
