{ pkgs }:

with pkgs;
let shared-packages = import ../shared/packages.nix { inherit pkgs; }; in
shared-packages ++ [
  dockutil
  google-cloud-sdk
  mas
  zsh
  nodejs
  mermaid-cli
]
