{
  description = "Template for hydenix configuration";

  nixConfig = {
    extra-substituters = ["https://hyprland.cachix.org"];
    extra-trusted-substituters = ["https://hyprland.cachix.org"];
    extra-trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  inputs = {
    nixpkgs.follows = "hydenix/nixpkgs";
    hydenix.url = "github:florianvazelle/hydenix";
    nixos-hardware.follows = "hydenix/nixos-hardware";
  };

  outputs = inputs: let
    hydenixConfig = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
      };
      modules = [
        ./configuration.nix
      ];
    };
    vmConfig = inputs.hydenix.lib.vmConfig {
      inherit inputs;
      nixosConfiguration = hydenixConfig;
    };
  in {
    nixosConfigurations.hydenix = hydenixConfig;
    nixosConfigurations.default = hydenixConfig;
    packages."x86_64-linux".vm = vmConfig.config.system.build.vm;
  };
}
