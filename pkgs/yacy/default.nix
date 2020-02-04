{ stdenv, jdk, ant, fetchFromGitHub }:
stdenv.mkDerivation rec {
  pname = "yacy";
  version = "master";
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "yacy";
    repo = "yacy_search_server";
    rev = "05137e4d6b6007d19dc848164915ea8876cd97ba";
    sha256 = "0jbb1w13msngkp21s0wv7wagp7q1xmicv7f8n09hbf2pihyb64hw";
  };

  buildInputs = [ jdk ];
  nativeBuildInputs = [ ant ];
  buildPhase = ''
    ant clean all dist
  '';
  installPhase = ''
    mkdir $out
    tar xfz RELEASE/yacy*tar.gz
    cp -r yacy/* $out
  '';
}
