{ config, pkgs, lib, ... }:
{
  nix-switch="pushd . > /dev/null && echo 'Cloning git repo...' && cd /tmp/ && git clone git@github.com:tunamelon/nix-config.git && cd nix-config && nix run .#build-switch; popd > /dev/null; rm -rf /tmp/nix-config; exec zsh";
  test = "echo my bb ty!";
}
