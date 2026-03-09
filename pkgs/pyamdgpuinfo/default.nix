{
  lib,
  python3,
  fetchFromGitHub,
  libdrm,
}:
python3.pkgs.buildPythonPackage rec {
  pname = "pyamdgpuinfo";
  version = "2.1.7";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "mark9064";
    repo = "pyamdgpuinfo";
    rev = "v2.1.7";
    hash = "sha256-e+pgLDe+fFgK+KNDuMkNSd2/1gorqSDQeSRJiRDZ5Nw=";
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
