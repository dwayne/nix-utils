# Tests

The flake is used to pin [Nixpkgs](https://nixos.org/manual/nixpkgs/stable/).

The tests are evaluated using [`lib.debug.runTests`](https://nixos.org/manual/nixpkgs/stable/#function-library-lib.debug.runTests). `lib.runTests` is an alias.

## How to run the tests

```
nix eval ./tests#tests
```
