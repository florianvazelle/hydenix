{pkgs}: let
  # Current pinned Hyde version
  hyde-pinned = pkgs.hyde;

  # Latest master Hyde version
  hyde-master = pkgs.hyde.overrideAttrs (_old: {
    src = pkgs.fetchFromGitHub {
      owner = "HyDE-Project";
      repo = "HyDE";
      rev = "master";
      sha256 = "sha256-cNOryXKFpVSTiAuzD0VQAV+2GQhJTTs1HBM6Z0cZoFo=";
    };
  });
in
  pkgs.writeShellApplication {
    name = "hyde-diff";
    runtimeInputs = with pkgs; [
      coreutils
      diffutils
    ];
    # Pass the built packages to the script
    text = ''
      export HYDE_PINNED="${hyde-pinned}"
      export HYDE_MASTER="${hyde-master}"
      ${builtins.readFile ./run.sh}
    '';
  }
