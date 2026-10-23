let
  nixpkgs = fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/nixpkgs-unstable.tar.gz";
    sha256 = "0n88mfr09bfb9bcgq4yysyvw9vzy8kkh2iyxa1dgldd33qn0mzs3";
  };

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
