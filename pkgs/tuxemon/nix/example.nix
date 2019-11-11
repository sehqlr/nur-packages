let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs { };
  pyscroll = import ../pyscroll;

in with pkgs;

python3Packages.buildPythonApplication rec {
  pname = "Tuxemon";
  version = "0.0.0";

  src = sources.Tuxemon;
  buildInputs = [ pyscroll ];
  propogatedBuildInputs = [ pyscroll ];
}
