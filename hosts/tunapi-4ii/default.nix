{ config, inputs, pkgs, agenix, ... }:
let user = "tuna";
    keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOk8iAnIaa1deoc7jw8YACPNVka1ZFJxhnU4G74TmS+p" ]; in
{
  imports = [
#    ../../modules/tunapi-4ii/secrets.nix
#    ../../modules/tunapi-4ii/disk-config.nix
#    ../../modules/shared
#    ../../modules/shared/cachix
     ../../modules/tunapi-4ii/home-manager.nix
#    agenix.nixosModules.default
    
  ];
  home.stateVersion = "21.11";
  nixpkgs.config.allowUnfree = true;
}
