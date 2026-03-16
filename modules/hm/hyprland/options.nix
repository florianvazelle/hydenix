{
  config,
  lib,
  ...
}: let
  cfg = config.hydenix.hm.hyprland;
in {
  options.hydenix.hm.hyprland = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.hm.enable;
      description = "Enable hyprland module";
    };
    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Extra config appended to userprefs.conf";
    };
    overrideMain = lib.mkOption {
      type = lib.types.nullOr lib.types.lines;
      default = null;
      description = "Complete override of hyprland.conf";
    };
    suppressWarnings = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Suppress warnings about configuration overrides";
    };

    systemd = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = cfg.enable;
        description = ''
          Whether to enable {file}`hyprland-session.target` on
          hyprland startup. This links to `graphical-session.target`.
          Some important environment variables will be imported to systemd
          and D-Bus user environment before reaching the target, including
          - `DISPLAY`
          - `HYPRLAND_INSTANCE_SIGNATURE`
          - `WAYLAND_DISPLAY`
          - `XDG_CURRENT_DESKTOP`
          - `XDG_SESSION_TYPE`
        '';
      };

      variables = lib.mkOption {
        type = with lib.types; listOf str;
        default = [
          "DISPLAY"
          "HYPRLAND_INSTANCE_SIGNATURE"
          "WAYLAND_DISPLAY"
          "XDG_CURRENT_DESKTOP"
          "XDG_SESSION_TYPE"
        ];
        example = ["--all"];
        description = ''
          Environment variables to be imported in the systemd & D-Bus user
          environment.
        '';
      };

      extraCommands = lib.mkOption {
        type = with lib.types; listOf str;
        default = [
          "systemctl --user stop hyprland-session.target"
          "systemctl --user start hyprland-session.target"
        ];
        description = "Extra commands to be run after D-Bus activation.";
      };

      enableXdgAutostart = lib.mkEnableOption ''
        autostart of applications using
        {manpage}`systemd-xdg-autostart-generator(8)`'';
    };

    # Animation configurations
    animations = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = cfg.enable;
        description = "Enable animation configurations";
      };
      preset = lib.mkOption {
        type = lib.types.str;
        default = "standard";
        description = "Animation preset to use";
        example = lib.literalExpression ''
          "standard" # any string in overrides or default: "LimeFrenzy", "classic", "diablo-1", "diablo-2", "disable", "dynamic", "end4", "fast", "high", "ja", "me-1", "me-2", "minimal-1", "minimal-2", "moving", "optimized", "standard", "vertical"
        '';
      };
      extraConfig = lib.mkOption {
        type = lib.types.lines;
        default = "";
        description = "Additional animation configuration";
      };
      overrides = lib.mkOption {
        type = lib.types.attrsOf lib.types.lines;
        default = {};
        description = "Override specific animation files by name";
        example = lib.literalExpression ''
          {
            "classic" = '''
              animation = windows, 1, 5, default
            ''';
          }
        '';
      };
    };

    # Shader configurations
    shaders = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = cfg.enable;
        description = "Enable shader configurations";
      };
      active = lib.mkOption {
        type = lib.types.str;
        default = "disable";
        description = "Active shader preset";
        example = lib.literalExpression ''
          "disable" # any string in overrides or default: "blue-light-filter", "color-vision", "custom", "grayscale", "invert-colors", "oled", "oled-saver", "paper", "vibrance", "wallbash"
        '';
      };
      overrides = lib.mkOption {
        type = lib.types.attrsOf lib.types.lines;
        default = {};
        description = "Override or add custom shaders";
        example = lib.literalExpression ''
          {
            "my-filter.frag" = '''
              precision mediump float;
              // Custom shader code
            ''';
          }
        '';
      };
    };

    # Workflow configurations
    workflows = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = cfg.enable;
        description = "Enable workflow configurations";
      };
      active = lib.mkOption {
        type = lib.types.str;
        default = "default";
        description = "Active workflow preset";
        example = lib.literalExpression ''
          "default" # any string in overrides or default: "editing", "gaming", "powersaver", "snappy"
        '';
      };
      overrides = lib.mkOption {
        type = lib.types.attrsOf lib.types.lines;
        default = {};
        description = "Override or add custom workflows";
        example = lib.literalExpression ''
          {
            "my-workflow.conf" = '''
              // Custom workflow configuration
            ''';
          }
        '';
      };
    };
  };
}
