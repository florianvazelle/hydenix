{
  pkgs,
  mkShell,
}:
mkShell {
  buildInputs = with pkgs; [
    typos
    just
  ];
}
