{ pkgs, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "jitsi-${version}";
  version = "4169";
  src = fetchFromGitHub {
        owner = "jitsi";
        repo = "jitsi-meet";
        rev = "4169";
        sha256 = "0qglayb1wb8sp7dffgdm0l740bcymsllsbcb7n5nk6409b9bv5dl";
  };
  buildPhase = "npm i && make";
  buildInputs = [ pkgs.jre pkgs.nodejs ];
}

