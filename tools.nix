let
  pkgs = import <nixpkgs> {};
  inherit (pkgs) buildEnv;

in buildEnv {
  name = "greeting-tools";
  paths = [ pkgs.hello pkgs.cowsay pkgs.figlet ];
}
