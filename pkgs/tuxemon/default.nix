let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs { };
  pyscroll = import ./nix/pyscroll.nix;
  pytmx = import ./nix/pytmx.nix;
  neteria = import ./nix/neteria.nix;
  
  commonInputs = with pkgs.python2Packages; [
    pyscroll
    neteria
    pytmx

    Babel
    cbor
    lxml
    pillow
    pygame
    requests
    rsa
    six
  ];

in with pkgs;

python2Packages.buildPythonApplication rec {
  pname = "Tuxemon";
  version = "0.0.0";

  src = sources.Tuxemon;
  buildInputs = commonInputs;
  propogatedBuildInputs = commonInputs;
}
