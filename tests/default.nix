let
  nixpkgs = import ./nixpkgs.nix;
  lib = import (nixpkgs + "/lib");
  nixUtils = import ../. lib;
in
lib.runTests {
  testEachSystem = {
    expr = nixUtils.eachSystem [ "a" "b" ] (system:
      {
        packages.default = "pkg-${system}";
        checks.test = "test-${system}";
      }
    );
    expected = {
      packages = {
        a.default = "pkg-a";
        b.default = "pkg-b";
      };
      checks = {
        a.test = "test-a";
        b.test = "test-b";
      };
    };
  };

  testForAllDefaultLinuxSystems = {
    expr = nixUtils.forAllDefaultLinuxSystems (system:
      {
        default = "pkg-${system}";
      }
    );
    expected = {
      "x86_64-linux" = { default = "pkg-x86_64-linux"; };
      "aarch64-linux" = { default = "pkg-aarch64-linux"; };
    };
  };
}
