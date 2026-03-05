{
  pkgs,
  mkTheme,
}:
mkTheme rec {
  name = "Crimson-Blue";
  src = pkgs.fetchFromGitHub {
    owner = "amit-0i";
    repo = "Crimson-Blue";
    rev = "5bc78a51f22b0cf4895bb3eda5bab8db412740fb";
    inherit name;
    sha256 = "sha256-MP2uTpH0rayCwHM2gWIaCbB0tARbMKLY9CUAZXPkM4U=";
  };
  meta = {
    inherit name;
    description = "HyDE Theme: Crimson-Blue";
    homepage = "https://github.com/amit-0i/Crimson-Blue";
  };
}
