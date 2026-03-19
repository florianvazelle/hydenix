{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.hydenix.hm.notifications;
in {
  options.hydenix.hm.notifications = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.hm.enable;
      description = "Enable notifications module";
    };

    dunst = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable dunst notification daemon";
      };
    };

    swaync = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable SwayNC notification daemon";
      };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    # Dunst (default)
    (lib.mkIf cfg.dunst.enable {
      home.packages = with pkgs; [
        dunst # notification daemon
      ];

      home.file = {
        ".config/dunst/dunstrc" = {
          source = "${pkgs.hyde}/Configs/.config/dunst/dunstrc";
          force = true;
          mutable = true;
        };
        ".config/dunst/dunst.conf" = {
          source = "${pkgs.hyde}/Configs/.config/dunst/dunst.conf";
          force = true;
          mutable = true;
        };
      };
    })

    # SwayNC (optional alternative)
    (lib.mkIf cfg.swaync.enable {
      home.packages = with pkgs; [
        swaynotificationcenter
      ];

      home.file = {
        ".config/swaync/config.json" = {
          source = "${pkgs.hyde}/Configs/.config/swaync/config.json";
          force = true;
          mutable = true;
        };
        ".config/swaync/style.css" = {
          source = "${pkgs.hyde}/Configs/.config/swaync/style.css";
          force = true;
          mutable = true;
        };
        ".config/swaync/user-style.css" = {
          source = "${pkgs.hyde}/Configs/.config/swaync/user-style.css";
          force = true;
          mutable = true;
        };
      };
    })
  ]);
}
