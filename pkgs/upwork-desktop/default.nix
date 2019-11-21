{ pkgs ? import <nixpkgs> {} }:
with pkgs;
stdenv.mkDerivation rec {
  version = "0.0.0";
  name = "upwork-desktop-${version}";
  src = ./upwork.deb;

  nativeBuildInputs = [ autoPatchelfHook dpkg ];

  buildInputs = [ glibc gcc-unwrapped gtk3 xorg.libX11 ];

  unpackPhase = "true";

  installPhase = ''
    mkdir -p $out
    dpkg -x $src $out
  '';
}
