# Ref: https://github.com/Gaming-Linux-FR/GLF-OS/blob/omnislash/modules/default/gaming.nix
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.hydenix.gaming;
in {
  options.hydenix.gaming = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.enable;
      description = "Enable gaming module";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (lutris.override {extraLibraries = p: [p.libadwaita p.gtk4];}) # Lutris Config with additional libraries
      heroic # Native GOG, Epic, and Amazon Games Launcher for Linux, Windows and Mac
      joystickwake # Joystick-aware screen waker
      mangohud # Vulkan and OpenGL overlay for monitoring FPS, temperatures, CPU/GPU load and more
      umu-launcher # Unified launcher for Windows games on Linux using the Steam Linux Runtime and Tools
      wineWow64Packages.staging # Open Source implementation of the Windows API on top of X, OpenGL, and Unix (with staging patches)
      winetricks # Script to install DLLs needed to work around problems in Wine
    ];

    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
      MANGOHUD_CONFIG = ''control=mangohud,legacy_layout=0,vertical,background_alpha=0,gpu_stats,gpu_power,cpu_stats,core_load,ram,vram,fps,fps_metrics=AVG,0.001,frametime,refresh_rate,resolution, vulkan_driver,wine'';
    };

    services.udev.extraRules = ''
      # USB
      ATTRS{name}=="Sony Interactive Entertainment Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
      ATTRS{name}=="Sony Interactive Entertainment DualSense Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
      # Bluetooth
      ATTRS{name}=="Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
      ATTRS{name}=="DualSense Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
    '';

    # Enable udev rules for Steam hardware such as the Steam Controller, other supported controllers and the HTC Vive
    hardware.steam-hardware.enable = true;
    # Enable the xone driver for Xbox One and Xbox Series X|S accessories
    hardware.xone.enable = true;
    # Enable the xpadneo driver for Xbox One wireless controllers
    hardware.xpadneo.enable = true;

    # Enable SteamOS session compositing window manager
    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };

    # Enable Steam
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
      localNetworkGameTransfers.openFirewall = true;
      extraCompatPackages = with pkgs; [proton-ge-bin];
    };
  };
}
