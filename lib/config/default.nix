{inputs, ...}: let
  system = "x86_64-linux";
  pkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
    overlays = [
      inputs.self.overlays.default
    ];
  };
in
  inputs.nixpkgs.lib.nixosSystem {
    inherit system pkgs;
    specialArgs = {
      inherit inputs;
    };
    modules = [
      ./configuration.nix
    ];
  }
