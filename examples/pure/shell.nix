{ nixpkgs ? import ./nixpkgs.nix }:

let
  lib = nixpkgs.lib;
  nixUtils = import ../.. lib;

  pkgs = import nixpkgs {};
  hello = pkgs.callPackage ../hello.nix {};
in
pkgs.mkShell {
  name = "pure";
  packages = [ hello ];
  shellHook = ''
    echo "Default Linux systems = ${builtins.toString nixUtils.defaultLinuxSystems}"
    echo "Default Mac systems = ${builtins.toString nixUtils.defaultMacSystems}"
    echo "Default systems = ${builtins.toString nixUtils.defaultSystems}"

    echo

    hello
  '';
}
