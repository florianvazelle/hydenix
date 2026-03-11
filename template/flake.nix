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
    system = "x86_64-linux";
    hydenixConfig = inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        # hydenix inputs - Required modules, don't modify unless you know what you're doing
        inputs.hydenix.nixosModules.default

        # Hardware Configuration - Uncomment lines that match your hardware
        # Run `lshw -short` or `lspci` to identify your hardware

        # GPU Configuration (choose one):
        # inputs.nixos-hardware.nixosModules.common-gpu-nvidia # NVIDIA
        # inputs.nixos-hardware.nixosModules.common-gpu-amd # AMD

        # CPU Configuration (choose one):
        # inputs.nixos-hardware.nixosModules.common-cpu-amd # AMD CPUs
        # inputs.nixos-hardware.nixosModules.common-cpu-intel # Intel CPUs

        # Additional Hardware Modules - Uncomment based on your system type:
        # inputs.nixos-hardware.nixosModules.common-hidpi # High-DPI displays
        # inputs.nixos-hardware.nixosModules.common-pc-laptop # Laptops
        # inputs.nixos-hardware.nixosModules.common-pc-ssd # SSD storage

        ./configuration.nix
      ];
    };
  in {
    nixosConfigurations.default = hydenixConfig;
    packages.${system}.vm = inputs.self.nixosConfigurations.default.config.system.build.vm;
  };
}
