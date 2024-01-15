{ config, pkgs, lib, ... }:
{
  nix-switch="pushd . > /dev/null && echo 'Cloning git repo...' && cd /tmp/ && git clone git@github.com:tunamelon/nix-config.git && cd nix-config && nix run .#build-switch; popd > /dev/null; rm -rf /tmp/nix-config; exec zsh";
  git-switch="pushd . > /dev/null && cd ~/nix-config && git add . && git commit -m \"Update darwin config\" && git push; popd > /dev/null && nix-switch";
  test = "echo It works!";
}
