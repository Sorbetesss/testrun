{
  stdenv,
  fetchurl,
  autoPatchelfHook,
  dpkg,
  libgcc,
  openssl,
  zlib,
  zstd,
}:

stdenv.mkDerivation rec {
  pname = "libmysqlclient-dev";
  version = "8.0.39-0ubuntu0.24.04.1";

  src = fetchurl {
    url = "http://security.ubuntu.com/ubuntu/pool/main/m/mysql-8.0/libmysqlclient21_${version}_amd64.deb";
    hash = "sha256-Gvs6F2cVGHmNxQo7nnFF8D/bn0chQ1KU4ZsgM3eAFl0=";
  };

  unpackPhase = ''
    dpkg -x $src .
  '';

  nativeBuildInputs = [
    autoPatchelfHook
    dpkg
    stdenv.cc.cc.lib
  ];

  buildInputs = [
    libgcc
  ];

  propagatedBuildInputs = [
    openssl
    zlib
    zstd
  ];

  installPhase = ''
    mkdir $out
    mv usr/lib/x86_64-linux-gnu/ $out/lib
    mv usr/share $out/share
  '';
}
