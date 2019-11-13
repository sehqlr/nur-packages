{ stdenv, dpkg, glibc, gcc-unwrapped, gtk3, libX11, autoPatchelfHook }:
stdenv.mkDerivation rec {
  version = "0.0.0";
  name = "upwork-desktop-${version}";
  src = ./upwork_5.3.3.800_amd64.deb;

  nativeBuildInputs = [ autoPatchelfHook dpkg ];

  buildInputs = [ glibc gcc-unwrapped gtk3 libX11 ];

  unpackPhase = "true";

  installPhase = ''
    mkdir -p $out
    dpkg -x $src $out
  '';
}
