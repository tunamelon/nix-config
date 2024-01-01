{ config, inputs, pkgs, agenix, ... }:
let user = "tuna";
    keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOk8iAnIaa1deoc7jw8YACPNVka1ZFJxhnU4G74TmS+p" ]; in
{
  imports = [
    ../../modules/tunapi-0/secrets.nix
    ../../modules/tunapi-0/disk-config.nix
    ../../modules/shared
    ../../modules/shared/cachix
    agenix.nixosModules.default
  ];

  # Set your time zone.
  time.timeZone = "Europe/London";

  system.stateVersion = "21.11"; # Don't change this
}
