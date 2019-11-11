let
  sources = import ./sources.nix;
  pkgs = import sources.nixpkgs { };
in with pkgs;

python2Packages.buildPythonPackage {
  name = "neteria";
  version = "0.0.0";

  src = sources.Neteria;
  buildInputs = [ python2Packages.rsa ];
  propogatedBuildInputs = [ python2Packages.rsa ];
}
