{pkgs, ...}: {
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Configure home-manager to manage user environments
  home-manager = {
    useGlobalPkgs = true; # Use the same package set as the system
    useUserPackages = true; # Install user packages to the user's profile
    users."hydenix" = import ./home.nix; # Import user-specific home-manager configuration
  };

  # Enable and configure the custom hydenix module
  hydenix = {
    enable = true; # Enable the hydenix system module
    hostname = "hydenix"; # Set the system hostname
    timezone = "America/Vancouver"; # Set the system timezone
    locale = "en_CA.UTF-8"; # Set the system locale
  };

  # Define the hydenix user account
  users.users."hydenix" = {
    isNormalUser = true; # Create a normal user account
    initialPassword = "hydenix"; # Set initial password (change after first login)
    extraGroups = [
      "wheel" # Allow sudo access
      "networkmanager" # Allow network management
      "video" # Allow access to video devices
    ];
    shell = pkgs.zsh; # Set the default shell to zsh
  };

  # Specify the NixOS release version for stateful data
  system.stateVersion = "25.05"; # Ensures compatibility with this NixOS version
}
