# nix-utils

A place for me to put values and functions I use frequently in my Nix-based projects.

## Values

- `defaultLinuxSystems :: [String]`
- `defaultMacSystems :: [String]`
- `defaultSystems :: [String]`

## Functions

The `eachSystem` approach:

- `eachSystem :: [String] -> (String -> AttrsOf a) -> AttrsOf (AttrsOf a)`
- `eachDefaultLinuxSystem :: (String -> AttrsOf a) -> AttrsOf (AttrsOf a)`
- `eachDefaultSystem :: (String -> AttrsOf a) -> AttrsOf (AttrsOf a)`

The `forAll` approach:

- `forAllDefaultLinuxSystems :: (String -> a) -> AttrsOf a`
- `forAllDefaultSystems :: (String -> a) -> AttrsOf a`

## Comments

`AttrsOf a` is shorthand for `{ [String] :: a }`, an attribute set with arbitrary keys whose values all have type `a`.
