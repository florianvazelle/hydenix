{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.hydenix.hm.wlogout;
in {
  options.hydenix.hm.wlogout = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.hm.enable;
      description = "Enable logout module";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      wlogout # logout menu
    ];

    home.file = {
      # icons
      ".config/wlogout/icons/" = {
        source = "${pkgs.hyde}/Configs/.config/wlogout/icons/";
        recursive = true;
        force = true;
      };

      # Stateful files with themes
      ".config/wlogout/layout_1" = {
        source = "${pkgs.hyde}/Configs/.config/wlogout/layout_1";
        force = true;
        mutable = true;
      };
      ".config/wlogout/style_1.css" = {
        source = "${pkgs.hyde}/Configs/.config/wlogout/style_1.css";
        force = true;
        mutable = true;
      };
      ".config/wlogout/layout_2" = {
        source = "${pkgs.hyde}/Configs/.config/wlogout/layout_2";
        force = true;
        mutable = true;
      };
      ".config/wlogout/style_2.css" = {
        source = "${pkgs.hyde}/Configs/.config/wlogout/style_2.css";
        force = true;
        mutable = true;
      };
    };
  };
}
