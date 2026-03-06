{
  description = "Nix & home-manager configuration for HyDE, an Arch Linux based Hyprland desktop";

  inputs = {
    # Hydenix's nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/80bdc1e5ce51f56b19791b52b2901187931f5353";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    # Nix-index-database - for comma and command-not-found
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyde = {
      url = "github:HyDE-Project/HyDE/v25.10.1";
      flake = false;
    };
    # HyDE related binaries
    hyq = {
      url = "github:florianvazelle/hyprquery";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hydectl = {
      url = "github:richen604/hydectl";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyde-ipc = {
      url = "github:richen604/hyde-ipc";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyde-config = {
      url = "github:richen604/hyde-config";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # treefmt (for formatting)
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs: let
    system = "x86_64-linux";
    pkgs = import inputs.nixpkgs {inherit system;};

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

    # Direct module access
    homeModules.default = import ./hydenix/modules/hm;
    nixosModules.default = import ./hydenix/modules/system;

    overlays.default = import ./hydenix/sources/overlay.nix {inherit inputs;};

    templates.default = {
      path = ./template;
      description = "Template for hydenix configuration";
    };

    nixosConfigurations.default = defaultConfig;

    packages.${system} = {
      # Use the VM configuration as default
      default = vmConfig.config.system.build.vm;

      # WIP: For a future demo installation & usage video
      demo-vm = demoVmConfig.config.system.build.vm;

      # Helper to manage hyde updates
      hyde-update = import ./lib/hyde-update {inherit inputs;};

      # Add hyq, hydectl, hyde-ipc, and hyde-config for building
      hyq = inputs.hyq.packages.${system}.default;
      hydectl = inputs.hydectl.packages.${system}.default;
      hyde-config = inputs.hyde-config.packages.${system}.default;
      # hyde-ipc = inputs.hyde-ipc.packages.${system}.default;
    };

    # for `nix flake check`
    checks.${system} = {
      # "formatting" = treefmtEval.config.build.check inputs.self;
      inherit (inputs.self.packages.${system}) hyq;
      inherit (inputs.self.packages.${system}) hydectl;
      inherit (inputs.self.packages.${system}) hyde-config;
      #FIXME: hyde-ipc has 2gb of build dependencies, so disable for now to prevent gh actions timeouts
      # hyde-ipc = inputs.self.packages.${system}.hyde-ipc;
    };

    # for `nix fmt`
    formatter.${system} = treefmtEval.config.build.wrapper;

    devShells.${system}.default = import ./lib/dev-shell.nix {inherit inputs;};
  };
}
