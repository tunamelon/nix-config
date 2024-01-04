{ config, pkgs, agenix, secrets, ... }:

let

  user = "tuna"; 
  home = "Users";

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
    path = "/Users/${user}/.ssh/id_github_TEST";
    file =  "${secrets}/github-ssh-key.age";
    mode = "600";
    owner = "${user}";
    group = "${user}";
  };

  age.secrets."secret" = {
    #publicKeys = systems;
    symlink = true;
    path = "/Users/${user}/secret.txt";
    file =  "${secrets}/secret.age";
    mode = "600";
    owner = "${user}";
    group = "${user}";
  };

  #age.secrets."github-signing-key" = {
  #   symlink = false;
  #   path = "/Users/${user}/.ssh/pgp_github.key";
  #   file =  "${secrets}/github-signing-key.age";
  #   mode = "600";
  #   owner = "${user}";
  #};



}
