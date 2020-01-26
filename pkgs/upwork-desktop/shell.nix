{ pkgs ? import <nixpkgs> {} }:
let upwork = import ./default.nix {};
in

(pkgs.buildFHSUserEnv {
  name = "upwork-desktop-env";
  targetPkgs = pkgs: [ upwork ];
  runScript = "upwork";
}).env
