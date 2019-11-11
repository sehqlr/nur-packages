let
  sources = import ./sources.nix;
  pkgs = import sources.nixpkgs { };
in with pkgs;

python2Packages.buildPythonPackage {
  name = "pytmx";
  version = "0.0.0";

  src = sources.PyTMX;
  buildInputs = [ python2Packages.six ];
  propogatedBuildInputs = [ python2Packages.six ];
}
