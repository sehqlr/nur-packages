{ buildGoPackage, fetchFromGitHub, pkgs, lib }:

buildGoPackage rec {
  pname = "grit";
  version = "0.3.0";

  goPackagePath = "github.com/climech/grit";
  
  src = fetchFromGitHub {
    owner = "climech";
    repo = "grit";
    rev = "v${version}";
    sha256 = "0sqfinl192bq81iqj7g93ip7ii64jcwyfjscx4nrp3n5cp103k3k";
  };
  
  meta = with lib; {
    description = ''
      Grit is an experimental personal task manager that represents tasks as nodes of a multitree, a class of directed acyclic graphs. The structure enables the subdivision of tasks, and supports short-term as well as long-term planning.
    '';
    homepage = "https://github.com/climech/grit";
    license = licenses.mit;
  };
}
