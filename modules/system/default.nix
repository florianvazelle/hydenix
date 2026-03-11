{
  lib,
  config,
  ...
}: let
  cfg = config.hydenix;

  nospace = str: lib.filter (c: c == " ") (lib.stringToCharacters str) == [];
  timezoneType =
    lib.types.nullOr (lib.types.addCheck lib.types.str nospace)
    // {
      description = "null or string without spaces";
    };
in {
  imports = [
    ./audio.nix
    ./boot.nix
    ./hardware.nix
    ./network.nix
    ./nix.nix
    ./sddm.nix
    ./system.nix
    ./gaming.nix
  ];

  options.hydenix = {
    enable = lib.mkEnableOption "Enable Hydenix modules globally";

    hostname = lib.mkOption {
      type = lib.types.str;
      description = "The name of the machine.";
      example = "hydenix";
      default = config.system.nixos.distroId;
    };

    timezone = lib.mkOption {
      type = timezoneType;
      description = "The time zone used when displaying times and dates.";
      example = "America/Vancouver";
      default = null;
    };

    locale = lib.mkOption {
      type = lib.types.str;
      description = "The default locale.";
      example = "en_CA.UTF-8";
      default = "en_US.UTF-8";
    };
  };

  config = {
    hydenix.enable = lib.mkDefault false;

    # Configuration for variables (only applied when hydenix is enabled)
    time.timeZone = lib.mkIf cfg.enable (lib.mkDefault cfg.timezone);
    i18n.defaultLocale = lib.mkIf cfg.enable (lib.mkDefault cfg.locale);
    networking.hostName = lib.mkIf cfg.enable (lib.mkDefault cfg.hostname);

    system.stateVersion = "25.05";
  };
}
