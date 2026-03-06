final: _prev: {
  # HyDE core packages
  hyde = final.callPackage ./hyde {};
  hyde-config = final.callPackage ./hyde-config {};
  hyde-gallery = final.callPackage ./hyde-gallery.nix {};
  hyde-ipc = final.callPackage ./hyde-ipc {};
  hydectl = final.callPackage ./hydectl {};
  hyprquery = final.callPackage ./hyprquery {};
  # Additional packages
  Bibata-Modern-Ice = final.callPackage ./Bibata-Modern-Ice.nix {};
  hydenix-themes = final.callPackage ./hydenix-themes {};
  pokego = final.callPackage ./pokego {};
  pyamdgpuinfo = final.callPackage ./pyamdgpuinfo {};
  Tela-circle-dracula = final.callPackage ./Tela-circle-dracula.nix {};
}
