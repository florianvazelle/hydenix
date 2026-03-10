<div align="center">

[![NixOS Unstable](https://img.shields.io/badge/NixOS-unstable-ebbcba.svg?style=flat-square&logo=NixOS&logoColor=white)](https://nixos.org)
[![Release](https://img.shields.io/github/v/release/florianvazelle/hydenix?style=flat-square&color=c79bf0)](https://github.com/florianvazelle/hydenix/releases)
[![Last Commit](https://img.shields.io/github/last-commit/florianvazelle/hydenix/main?style=flat-square&color=ebbcba)](https://github.com/florianvazelle/hydenix/commits/main)
[![Nix Flake Check](https://img.shields.io/github/actions/workflow/status/florianvazelle/hydenix/flake-check.yml?style=flat-square&color=c79bf0&label=flake%20check)](https://github.com/florianvazelle/hydenix/actions/workflows/flake-check.yml)

</div>

<div align="center">
<a href="https://discord.gg/AYbJ9MJez7">
<img alt="Dynamic JSON Badge" src="https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fdiscordapp.com%2Fapi%2Finvites%2FmT5YqjaJFh%3Fwith_counts%3Dtrue&query=%24.approximate_member_count&suffix=%20members&style=for-the-badge&logo=discord&logoSize=auto&label=The%20HyDe%20Project&labelColor=ebbcba&color=c79bf0">
</a>
<br>

<https://github.com/user-attachments/assets/7f8fadc8-e293-4482-a851-e9c6464f5265>

</div>

<br>

<img align="right" width="75px" alt="NixOS" src="https://github.com/HyDE-Project/HyDE/blob/master/Source/assets/nixos.png?raw=true"/>

# hydenix

**hydenix** is a **NixOS + Home Manager configuration** for [HyDE](https://github.com/HyDE-Project/HyDE).

It brings the HyDE desktop experience to NixOS while taking advantage of
the Nix module system and reproducible configuration management.


## ✨ Features

- Declarative configuration via `hydenix` and `hydenix.hm` options
- Built on the **NixOS module system** (easily extend, override, or disable modules)
- Close feature parity with the upstream [HyDE](https://github.com/HyDE-Project/HyDE)
- Support for all community themes from [hyde-gallery](https://github.com/HyDE-Project/hyde-gallery)
- Fully reproducible desktop environments
- Easy system rollbacks
- Version-controlled desktop configuration

## 📋 Requirements

- A **minimal NixOS installation**

Follow the official instructions from the [NixOS installation ISO](https://nixos.org/download/#nixos-iso).

> [!IMPORTANT]  
> Some familiarity with **functional programming concepts** is recommended.  
>  
> If you are new to Nix, check the  [Nix resources](./docs/src/faq.md#how-do-i-learn-more-about-nix) or ask questions in **Discussions** or **Discord**.

## 📚 Documentation

- [Installation](./docs/src/installation.md)
- [Upgrading](./docs/src/upgrading.md)
- [Module Options](./docs/src/options.md)
- [FAQ](./docs/src/faq.md)
- [Troubleshooting & Issues](./docs/src/troubleshooting.md)
- [Contributing](./docs/src/contributing.md)
- [Community Configurations](./docs/src/community.md)
<!-- - [Roadmap / Upcoming Features](./TODO.md) -->

## 🖥️ hydenix VM

If your system supports virtualization, you can try **hydenix in a NixOS VM** without installing it on your machine.

If you encounter issues running Hyprland inside the VM, see the [VirtIO guide](./docs/src/faq.md#how-do-i-run-hyprland-in-a-vm).

```bash
# run the flake remotely
nix run github:florianvazelle/hydenix
```

> [!NOTE]
> Any configuration changes require rebuilding the VM.
> To reset it, delete the disk image:
> ```
> rm hydenix.qcow2
> ```
