{ config, pkgs, lib, ... }:
{
  #nix-switch = "nix run github:tunamelon/nix-config#build-switch && exec zsh";
  nix-switch = "echo Cloning git repo... && cd /tmp && git clone git@github.com:tunamelon/nix-config.git && cd nix-config && .#build-switch && exec zsh && cd ~/ && rm -rf /tmp/nix-config";
  test = "echo my bb ty!";
}
