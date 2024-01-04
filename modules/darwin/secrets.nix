{ config, pkgs, agenix, secrets, ... }:

let

  user = "tuna"; 
  home = "Users";

  # Public keys
  macos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFHa7ofDgHgTBw3/gzxWE56EJdhjWuhDTgqyIovdEV3m tuna@Tunas-MacBook-Air.local";
  macos2 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII0qGdfsS0prYj2z0Vupf6LM4XQ7TfRzGoKsMQqtokKV tuna@macnix.local";
  # users = [ ];
  systems = [ macos macos2 ];

in

{
  age.identityPaths = [ 
    "/Users/${user}/.ssh/id_ed25519"
  ];

  # Your secrets go here
  #
  # Note: the installWithSecrets command you ran to boostrap the machine actually copies over
  #       a Github key pair. However, if you want to store the keypair in your nix-secrets repo
  #       instead, you can reference the age files and specify the symlink path here. Then add your
  #       public key in shared/files.nix.
  #
  #       If you change the key name, you'll need to update the SSH extraConfig in shared/home-manager.nix
  #       so Github reads it correctly.

  #
  age.secrets."github-ssh-key" = {
    symlink = true;
    path = "/Users/${user}/.ssh/id_github";
    file =  "${secrets}/github-ssh-key.age";
    mode = "600";
    owner = "${user}";
    group = "${user}";
  };

  age.secrets."secret" = {
#    publicKeys = systems;
    symlink = true;
    path = "/Users/${user}/secret.txt";
    file =  "${secrets}/secret.age";
    mode = "600";
    owner = "${user}";
    group = "${user}";
  };

  # age.secrets."github-signing-key" = {
  #   symlink = false;
  #   path = "/Users/${user}/.ssh/pgp_github.key";
  #   file =  "${secrets}/github-signing-key.age";
  #   mode = "600";
  #   owner = "${user}";
  # };



}
