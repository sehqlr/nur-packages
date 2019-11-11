{ stdenv, autoreconfHook, pkgconfig, libressl, boost, libevent , db48 }:
stdenv.mkDerivation rec {
  name = "gridcoin-research-base";
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
