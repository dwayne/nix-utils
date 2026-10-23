lib:

let
  #
  # x86_64-linux:
  #   - 64-bit Intel/AMD Linux
  #   - Most servers and cloud VMs
  #   - Standard GitHub Actions runners
  #   - WSL2
  #   - Highest level of support in Nixpkgs
  #
  # aarch64-linux:
  #   - 64-bit ARM Linux
  #   - Well supported
  #   - Most packages build successfully in CI
  #
  defaultLinuxSystems =
    [
      "x86_64-linux"
      "aarch64-linux"
    ];

  #
  # aarch64-darwin:
  #   - Apple Silicon Macs (M1 and later)
  #   - Include it if you or your users develop on a Mac
  #
  defaultMacSystems =
    [
      "aarch64-darwin"
    ];

  defaultSystems =
    defaultLinuxSystems
    ++ defaultMacSystems;

  #
  # eachSystem [ ... ] (system:
  #   let
  #     pkgs = nixpkgs.legacyPackages.${system};
  #   in
  #   {
  #     devShells.default = pkgs.mkShell {
  #       name = "shell";
  #
  #       packages = [
  #         pkgs.elmPackages.elm
  #       ]
  #     }
  #
  #     packages = {
  #       ...
  #     }
  #
  #     apps = {
  #       ...
  #     }
  #
  #     checks = {
  #       ...
  #     }
  #   }
  # )
  #
  eachSystem = systems: f:
    lib.foldAttrs
      lib.mergeAttrs
      {}
      (map
        (s:
          lib.mapAttrs
            (_: v: { ${s} = v; })
            (f s)
        )
        systems
      );

  eachDefaultLinuxSystem = eachSystem defaultLinuxSystems;
  eachDefaultSystem = eachSystem defaultSystems;

  #
  # apps = forAllDefaultSystems (system:
  #   {
  #     serve = {
  #       type = "app";
  #       program = lib.getExe self.packages.${system}.serve;
  #       meta.description = "Serve ...";
  #     }
  #   }
  # )
  #
  # What if you wanted to pass `pkgs` instead of `system`?
  #
  # forAll = f:
  #   forAllDefaultSystems (system:
  #     f nixpkgs.legacyPackages.${system}
  #   )
  #
  # Nothing is stopping you from passing both `system` and `pkgs`.
  #
  # forAll = f:
  #   forAllDefaultSystems (system:
  #     f system nixpkgs.legacyPackages.${system}
  #   )
  #
  # packages = forAll (system: pkgs:
  #   {
  #     default = self.packages.${system}.deploy;
  #     deploy = self.lib.mkDeploy pkgs;
  #   }
  # )
  #
  forAllDefaultLinuxSystems = lib.genAttrs defaultLinuxSystems;
  forAllDefaultSystems = lib.genAttrs defaultSystems;
in
{ inherit
    defaultLinuxSystems defaultMacSystems defaultSystems
    eachSystem eachDefaultLinuxSystem eachDefaultSystem
    forAllDefaultLinuxSystems forAllDefaultSystems
    ;
}
