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
    hash = "sha256-/dfxfhm6gMAgZMh96z1otToM940TO1dwwyOLzsCjq78=";
  };

  vendorHash = "sha256-qQ7rr2Y+AnnuyW/N/ogwzT6lvyixHK31lM77Sv3ziiE=";
  proxyVendor = true;

  meta = with lib; {
    description = "A Go-based tool for parsing TOML configuration files for HyDE and Hyprland";
    homepage = "https://github.com/HyDE-Project/hyde-config";
    maintainers = [];
    platforms = platforms.linux;
    mainProgram = "hyde-config";
  };
}
