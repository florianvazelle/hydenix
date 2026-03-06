{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.hydenix.hm.uwsm;
in {
  options.hydenix.hm.uwsm = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.hm.enable;
      description = "Enable uwsm module";
    };
  };

  config = lib.mkIf cfg.enable {
    home.file = {
      ".config/uwsm/env" = {
        source = "${pkgs.hyde}/Configs/.config/uwsm/env";
        force = true;
      };
      ".config/uwsm/env.d/00-hyde.sh" = {
        source = "${pkgs.hyde}/Configs/.config/uwsm/env.d/00-hyde.sh";
        force = true;
      };
      ".config/uwsm/env.d/01-gpu.sh" = {
        source = "${pkgs.hyde}/Configs/.config/uwsm/env.d/01-gpu.sh";
        force = true;
      };
      ".config/uwsm/env-hyprland" = {
        source = "${pkgs.hyde}/Configs/.config/uwsm/env-hyprland";
        force = true;
      };
      ".config/uwsm/env-hyprland.d/00-hyde.sh" = {
        source = "${pkgs.hyde}/Configs/.config/uwsm/env-hyprland.d/00-hyde.sh";
        force = true;
      };
    };
  };
}
