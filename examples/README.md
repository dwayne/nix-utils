# Example

It shows how to use `nix-utils`.

The example script says "Hello, world!" using [cowsay](https://cowsay.diamonds/).

## Usage

### Flake

**Develop**

```bash
nix develop ./examples/flake
```

**Run**

```bash
nix run ./examples/flake
```

**Build**

```bash
nix build ./examples/flake
```

### Pure

**Interactive shell**

```bash
nix-shell ./examples/pure
```
