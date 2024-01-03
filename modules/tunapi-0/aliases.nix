{ config, pkgs, lib, ... }:
{
  nix-switch = "home-manager switch --flake github:tunamelon/nix-config#tunapi-0 && exec zsh";

  # Ripgrep alias
#  alias search=rg -p --glob '!node_modules/*'  $@

  # Always color ls and group directories
  alias ls='ls --color=auto'
}
