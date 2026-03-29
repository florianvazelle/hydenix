{
  lib,
  python3,
  fetchFromGitHub,
  libdrm,
}:
python3.pkgs.buildPythonPackage rec {
  pname = "pyamdgpuinfo";
  version = "2.1.8";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "mark9064";
    repo = "pyamdgpuinfo";
    rev = "v2.1.8";
    hash = "sha256-K4PcIgYn9lC6iHNjL9AQ1dUQEBueWbAF98BPC/xiBgE=";
  };

  nativeBuildInputs = with python3.pkgs; [
    setuptools
    wheel
    cython
  ];

  buildInputs = [
    libdrm
    libdrm.dev
  ];

  NIX_CFLAGS_COMPILE = "-I${libdrm.dev}/include/libdrm";

  pythonImportsCheck = ["pyamdgpuinfo"];

  meta = {
    description = "AMD GPU stats";
    homepage = "https://github.com/mark9064/pyamdgpuinfo";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
  };
}
