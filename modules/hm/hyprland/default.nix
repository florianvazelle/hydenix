{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.hydenix.hm.hyprland;
  mkHyprConfig = import ./utils/mkHyprConfig.nix {inherit lib pkgs config;};

  variables = builtins.concatStringsSep " " cfg.systemd.variables;
  extraCommands = builtins.concatStringsSep " " (map (f: "&& ${f}") cfg.systemd.extraCommands);
  systemdActivation = ''
    exec-once = ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd ${variables} ${extraCommands}
  '';
in {
  imports = [
    ./animations.nix
    ./assertions.nix
    ./options.nix
    ./shaders.nix
    ./workflows.nix
    (mkHyprConfig "hypridle")
    (mkHyprConfig "keybindings")
    (mkHyprConfig "monitors")
    (mkHyprConfig "nvidia")
    (mkHyprConfig "windowrules")
  ];

  config = lib.mkIf cfg.enable {
    # Always include packages and base setup
    home.packages = [
      pkgs.hyprutils
      pkgs.hyprpicker
      pkgs.hyprcursor
    ];

    home.activation.createHyprConfigs = lib.hm.dag.entryAfter ["mutableGeneration"] ''
      mkdir -p "$HOME/.config/hypr/animations"
      mkdir -p "$HOME/.config/hypr/themes"
      mkdir -p "$HOME/.config/hypr/shaders"
      mkdir -p "$HOME/.config/hypr/workflows"

      touch "$HOME/.config/hypr/animations/theme.conf"
      touch "$HOME/.config/hypr/themes/colors.conf"
      touch "$HOME/.config/hypr/themes/theme.conf"
      touch "$HOME/.config/hypr/themes/wallbash.conf"

      chmod 644 "$HOME/.config/hypr/animations/theme.conf"
      chmod 644 "$HOME/.config/hypr/themes/colors.conf"
      chmod 644 "$HOME/.config/hypr/themes/theme.conf"
      chmod 644 "$HOME/.config/hypr/themes/wallbash.conf"
    '';

    home.file = {
      ".local/share/hypr/" = {
        source = "${pkgs.hyde}/Configs/.local/share/hypr/";
        recursive = true;
        force = true;
      };

      ".config/hypr/hyprland.conf" =
        if cfg.overrideMain != null
        then {
          text = cfg.overrideMain;
          force = true;
        }
        else {
          text = ''
            ${lib.readFile "${pkgs.hyde}/Configs/.config/hypr/hyprland.conf"}
            ${systemdActivation}
          '';
          force = true;
        };

      ".config/hypr/userprefs.conf" = {
        text = cfg.extraConfig;
        force = true;
      };
    };

    systemd.user.targets.hyprland-session = lib.mkIf cfg.systemd.enable {
      Unit = {
        Description = "Hyprland compositor session";
        Documentation = ["man:systemd.special(7)"];
        BindsTo = ["graphical-session.target"];
        Wants =
          [
            "graphical-session-pre.target"
          ]
          ++ lib.optional cfg.systemd.enableXdgAutostart "xdg-desktop-autostart.target";
        After = ["graphical-session-pre.target"];
        Before = lib.mkIf cfg.systemd.enableXdgAutostart ["xdg-desktop-autostart.target"];
      };
    };
  };
}
