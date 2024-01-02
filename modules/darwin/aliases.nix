{ config, pkgs, lib, ... }:
{
  nix-switch = "nix run github:tunamelon/nix-config#build-switch && exec zsh";
  test = "echo my bb ty!";
}
