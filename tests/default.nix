lib:

let
  nix-utils = import ../. lib;
in
lib.runTests {
  testEachSystem = {
    expr = nix-utils.eachSystem [ "a" "b" ] (system:
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
    expr = nix-utils.forAllDefaultLinuxSystems (system:
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
