{ cowsay, writeShellApplication }:
writeShellApplication {
  name = "hello";
  runtimeInputs = [ cowsay ];
  text = builtins.readFile ./hello.sh;
}
