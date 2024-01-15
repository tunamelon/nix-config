{ config, pkgs, lib, ... }:

let
  email = "tuna@sodamelon.com";
  user = "tuna";
  name = "Tuna";
  customAliases = import ./aliases.nix { inherit config pkgs lib; };
  shared-files = import ../shared/files.nix { inherit config pkgs; };


in
{
  home = {
    enableNixpkgsReleaseCheck = false;
    username = "${user}";
    homeDirectory = "/home/${user}";
    packages = pkgs.callPackage ./packages.nix {};
    file = shared-files // import ./files.nix { inherit user; };
    stateVersion = "21.11";
  };

  # Enable Docker service
  #services.docker = {
  #  enable = true;
  #};

  programs.zsh = {
    enable = true;
    autocd = false;
    cdpath = [ "~/.local/share/src" ];
    plugins = [
      {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
          name = "powerlevel10k-config";
          src = lib.cleanSource ../shared/config/p10k;
          file = "p10k.zsh";
      }
    ];
    shellAliases = customAliases; # imports from aliases.nix
    initExtraFirst = ''
      

      if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      fi

      # Define variables for directories
      export PATH=$HOME/.local/share/bin:$PATH

      # Remove history data we don't want to see
      export HISTIGNORE="pwd:ls:cd"

      #POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
      #  Editors
      export ALTERNATE_EDITOR="vim"
      export EDITOR="nvim"
      export VISUAL="codium --wait"

      # nix shortcuts
      shell() {
          nix-shell '<nixpkgs>' -A "$1"
      }

    '';
  };

  programs.git = {
    enable = true;
    ignores = [ "*.swp" ];
    userName = name;
    userEmail = email;
    lfs = {
      enable = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      core = {
            editor = "vim";
        autocrlf = "input";
      };
      commit.gpgsign = false;
      pull.rebase = true;
      rebase.autoStash = true;
    };
  };

  

}
