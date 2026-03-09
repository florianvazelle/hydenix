{
  description = "Nix & home-manager configuration for HyDE, an Arch Linux based Hyprland desktop";

  nixConfig = {
    extra-substituters = ["https://hyprland.cachix.org"];
    extra-trusted-substituters = ["https://hyprland.cachix.org"];
    extra-trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/aca4d95fce4914b3892661bcb80b8087293536c6";
    # Home Manager (for user specific configuration)
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # NixOS hardware (for hardware profiles)
    nixos-hardware.url = "github:nixos/nixos-hardware";

    # Hyprland (pin it to the latest version supported by HyDE)
    hyprland.url = "github:hyprwm/Hyprland/v0.52.2";

    # Nix-index-database (for comma and command-not-found)
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # treefmt (for formatting)
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs: let
    system = "x86_64-linux";
    pkgs = import inputs.nixpkgs {
      inherit system;
      overlays = [inputs.self.overlays.default];
    };

    # Eval the treefmt modules from ./treefmt.nix
    treefmtEval = inputs.treefmt-nix.lib.evalModule pkgs ./treefmt.nix;

    defaultConfig = import ./lib/config {
      inherit inputs;
    };

    # Create VM variant of the NixOS configuration
    vmConfig = import ./lib/vms/nixos-vm.nix {
      inherit inputs;
      nixosConfiguration = defaultConfig;
    };

    demoVmConfig = import ./lib/vms/demo-vm.nix {
      inherit inputs;
    };
  in {
    lib.vmConfig = import ./lib/vms/nixos-vm.nix;

    # Define custom NixOS modules
    homeModules.default = import ./modules/hm;

    # Define custom NixOS modules
    nixosModules.default = import ./modules/system;

    # Define custom NixOS overlays
    overlays.default = final: prev: (inputs.hyprland.overlays.default final prev) // (import ./pkgs final prev);

    # for `nix flake new -t <template>`
    templates.default = {
      path = ./template;
      description = "Template for hydenix configuration";
    };

    # for `nix build .#nixosConfigurations.<name>`
    nixosConfigurations.default = defaultConfig;

    packages.${system} = {
      # Use the VM configuration as default
      default = vmConfig.config.system.build.vm;

      # TODO: For a future demo installation & usage video
      demo-vm = demoVmConfig.config.system.build.vm;

      # Helper to manage hyde updates
      hyde-update = pkgs.callPackage ./lib/hyde-update {};

      # Add hyprquery, hydectl, hyde-ipc, and hyde-config for building
      inherit (pkgs) hyprquery hydectl hyde-config hyde-ipc hyde hyde-gallery;
      inherit (pkgs) pokego pyamdgpuinfo;
    };

    # for `nix flake check`
    checks.${system} = {
      # "formatting" = treefmtEval.config.build.check inputs.self;
      inherit (pkgs) hyprquery hydectl hyde-config hyde-ipc;
    };

    # for `nix fmt`
    formatter.${system} = treefmtEval.config.build.wrapper;

    # for `nix develop`
    devShells.${system}.default = pkgs.callPackage ./shell.nix {};
  };
}
