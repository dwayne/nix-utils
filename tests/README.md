# Tests

The tests are evaluated using [`lib.debug.runTests`](https://nixos.org/manual/nixpkgs/stable/#function-library-lib.debug.runTests). `lib.runTests` is an alias.

## Run tests

```
nix eval --file ./tests
```

## Update `nixpkgs`

```bash
cd tests
./update-nixpkgs.sh
```
