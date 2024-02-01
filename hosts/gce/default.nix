{ config, inputs, pkgs, agenix, ... }:
let user = "tuna";
    keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOk8iAnIaa1deoc7jw8YACPNVka1ZFJxhnU4G74TmS+p" ]; in
{
  imports = [
#    ../../modules/gce/secrets.nix
#    ../../modules/gce/disk-config.nix
#    ../../modules/shared
#    ../../modules/shared/cachix
     ../../modules/gce/home-manager.nix
#    agenix.nixosModules.default
    
  ];
  home.stateVersion = "21.11";
  nixpkgs.config.allowUnfree = true;
}
