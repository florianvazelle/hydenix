{
  config,
  pkgs,
  lib,
  ...
}: {
  name,
  extension ? "conf",
}: let
  hyprCfg = config.hydenix.hm.hyprland;
  cfg = hyprCfg.${name};
in {
  options.hydenix.hm.hyprland.${name} = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = hyprCfg.enable;
      description = "Enable ${name} configurations";
    };

    overrideConfig = lib.mkOption {
      type = lib.types.nullOr lib.types.lines;
      default = null;
      description = "Completely ${name} configuration override";
    };

    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Additional ${name} configuration";
    };
  };

  config = lib.mkIf (hyprCfg.enable && cfg.enable) {
    home.file.".config/hypr/${name}.${extension}" = {
      text =
        if cfg.overrideConfig != null
        then cfg.overrideConfig
        else ''
          ${lib.readFile "${pkgs.hyde}/Configs/.config/hypr/${name}.${extension}"}
          ${cfg.extraConfig}
        '';
      force = true;
      mutable = true;
    };
  };
}
