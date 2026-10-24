{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-utils-src = { url = ../../.; flake = false; };
  };

  outputs = { self, nixpkgs, nix-utils-src }:
    let
      lib = nixpkgs.lib;
      nixUtils = import nix-utils-src lib;
    in
    nixUtils.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        hello = pkgs.callPackage ../hello.nix {};
      in
      {
        devShells.default = pkgs.mkShell {
          name = "flake";
          packages = [ hello ];
          shellHook = ''
            echo "Default Linux systems = ${builtins.toString nixUtils.defaultLinuxSystems}"
            echo "Default Mac systems = ${builtins.toString nixUtils.defaultMacSystems}"
            echo "Default systems = ${builtins.toString nixUtils.defaultSystems}"

            echo

            hello
          '';
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
