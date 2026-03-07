{
  buildGoModule,
  fetchFromGitHub,
  lib,
}:
buildGoModule {
  pname = "hyde-config";
  version = "0.1.4";

  src = fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-config";
    rev = "v0.1.4";
    hash = "df0fe096b06fe892e17ffe38a8781ba76673e737";
  };

  vendorHash = "sha256-qQ7rr2Y+AnnuyW/N/ogwzT6lvyixHK31lM77Sv3ziiE=";
  proxyVendor = true;

  meta = with lib; {
    description = "A Go-based tool for parsing TOML configuration files for HyDE and Hyprland";
    homepage = "https://github.com/HyDE-Project/hyde-config";
    maintainers = ["florianvazelle"];
    platforms = platforms.linux;
    mainProgram = "hyde-config";
  };
}
