let
  sources = import ./sources.nix;
  pkgs = import sources.nixpkgs { };
in with pkgs;

python2Packages.buildPythonPackage {
  name = "pyscroll";
  version = "0.0.0";

  src = sources.pyscroll;
  buildInputs = [ python2Packages.pygame ];
  propogatedBuildInputs = [ python2Packages.pygame ];
}
