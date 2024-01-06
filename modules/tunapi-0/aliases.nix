{ config, pkgs, lib, ... }:
{
  nix-switch = "nix-collect-garbage -d; home-manager switch --flake github:tunamelon/nix-config#tunapi-0 && exec zsh";

  # Ripgrep alias
#  search = "rg -p --glob '!node_modules/*'  $@";

  # Always color ls and group directories
  ls = "ls --color=auto";
}
