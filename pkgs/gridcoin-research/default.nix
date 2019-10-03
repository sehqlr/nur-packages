{ stdenv, fetchFromGitHub, autoreconfHook, pkgconfig, libressl, boost, libevent
, db48 }:
stdenv.mkDerivation rec {
  name = "gridcoin-research-base";
  src = fetchFromGitHub {
    owner = "gridcoin-community";
    repo = "Gridcoin-Research";
    rev = "ddaaf8d5a505ef213f0a1255a162c1eb24b3cc3f";
    sha256 = "15i1k3nchgdk4xz4jq64mvq1r096v1ypqz1lcxy3fcrwgjn9kx9l";
  };
  nativeBuildInputs = [ pkgconfig autoreconfHook ];
  buildInputs = [ boost db48 libevent libressl ];
  configFlags = [ "--without-gui" "--without-miniupnpc" ];
  meta = with stdenv.lib; {
    description = "Gridcoin wallet";
    homepage = "https://github.com/gridcoin-community/Gridcoin-Research";
    license = licenses.mit;
    platforms = platforms.linux;
    broken = true;
  };
}
