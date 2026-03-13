{pkgs}:
pkgs.writeShellApplication {
  name = "hyde-diff-home";
  runtimeInputs = with pkgs; [
    coreutils
    diffutils
    findutils
  ];
  # Pass the built packages to the script
  text = ''
    export HYDE_PINNED="${pkgs.hyde}"
    ${builtins.readFile ./run.sh}
  '';
}
