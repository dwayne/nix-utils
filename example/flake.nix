{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-utils = { url = ../.; flake = false; };
  };

  outputs = { self, nixpkgs, nix-utils }:
    let
      lib = nixpkgs.lib;
      nixUtils = import nix-utils lib;
    in
    nixUtils.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        hello = pkgs.writeShellApplication {
          name = "hello";
          runtimeInputs = [ pkgs.cowsay ];
          text = builtins.readFile ./hello.sh;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          name = "example";
          packages = [ hello ];
        };

        packages = {
          inherit hello;
          default = hello;
        };

        apps = {
          default = self.apps.${system}.hello;
          hello = {
            type = "app";
            program = lib.getExe hello;
            meta.description = "Say hello";
          };
        };

        checks = { inherit hello; };
      }
    );
}
