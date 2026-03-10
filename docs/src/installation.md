# Installation

> [!CAUTION]
> The provided flake template assumes a **minimal NixOS installation**.
> Install NixOS first, then follow the steps below.

## 1. Initialize the flake template

Create a new directory for your configuration and initialize the **hydenix flake template**.

```bash
# create a new directory and initialize the template
mkdir hydenix
cd hydenix

nix flake init -t github:florianvazelle/hydenix
```

This will generate the base configuration files required for hydenix.

## 2. Configure your system

Open and edit the `configuration.nix` file and follow the inline comments to configure your system.

Optional:
For advanced customization, see the [module options](./options.md).

---

## 3. Generate hardware configuration

Generate the hardware configuration for your machine:

```bash
sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
```

This file contains hardware-specific settings such as drivers and device configuration.

## 4. Initialize a Git repository

Flakes require the configuration to be managed in a **Git repository**.

```bash
git init
git add .
```

Using Git also allows you to **version control and track changes** to your system configuration.

## 5. Build and apply the configuration

Build the system and switch to the new configuration:

```bash
sudo nixos-rebuild switch --flake .#hydenix
```

> [!NOTE]
> If something was misconfigured, the build may fail at this step. If that happens:
>
> * Carefully read the error message — it often explains the issue.
> * Check the [troubleshooting & issues](./troubleshooting.md) guide.
> * Search the [faq](./faq.md).
> * Ask the community for help:
>
>   * Discord: <https://discord.gg/AYbJ9MJez7>
>   * GitHub Discussions: <https://github.com/florianvazelle/hydenix/discussions>

## 6. Launch hydenix

Reboot your system and log in.

> [!IMPORTANT]
> Make sure your user password is set:
>
> ```bash
> passwd
> ```

After logging in, generate the theme cache:

```bash
hyde-shell reload
```

hydenix should now be installed and ready to use.
