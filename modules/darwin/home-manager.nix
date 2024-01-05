{ config, pkgs, lib, home-manager, ... }:

let
  user = "tuna";
  # Define the content of your file as a derivation
  #myEmacsLauncher = pkgs.writeScript "emacs-launcher.command" ''
  #  #!/bin/sh
  #  emacsclient -c -n &
  #'';
  sharedFiles = import ../shared/files.nix { inherit config pkgs; };
  sharedConfig = import ../shared/home-manager.nix { inherit config pkgs lib; };
  customAliases = import ./aliases.nix { inherit config pkgs lib; };
  additionalFiles = import ./files.nix { inherit user config pkgs; };
in
{
  imports = [
    ./dock
  ];

  # It me
  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };
  
  nix = {
    #package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  homebrew = {
    enable = true;
    casks = pkgs.callPackage ./casks.nix {};

    # These app IDs are from using the mas CLI app
    # mas = mac app store
    # https://github.com/mas-cli/mas
    #
    # $ nix shell nixpkgs#mas
    # $ mas search <app name>
    #
    masApps = {
      "Bitwarden" = 1352778147;
      "Moom" = 419330170;
    };
  };

  # Enable home-manager
  home-manager = {
    useGlobalPkgs = true;
    users.${user} = { pkgs, config, lib, ... }:{
      home = {
        enableNixpkgsReleaseCheck = false;
        packages = pkgs.callPackage ./packages.nix {};
        file = lib.mkMerge [
          sharedFiles
          additionalFiles
          #{ "emacs-launcher.command".source = myEmacsLauncher; }
        ];

        stateVersion = "23.11";
      };

      # Merges shared home-manager with host specific programs:
      programs = lib.mkMerge [
          sharedConfig # merges shared home-manager.nix
          { 
            # Host specific programs:
            zsh = {
              shellAliases = customAliases; # imports from aliases.nix
            };
          }
        ];
      
      # Marked broken Oct 20, 2022 check later to remove this
      # https://github.com/nix-community/home-manager/issues/3344
      manual.manpages.enable = false;
    };
  };


  # Fully declarative dock using the latest from Nix Store
  local = { 
    dock = {
      enable = true;
      entries = [
        # System apps
        { path = "${pkgs.alacritty}/Applications/Alacritty.app/"; }
        { path = "/System/Applications/System Settings.app/"; }

        # User apps
        { path = "/Applications/Firefox.app/"; }
        { path = "/Applications/Thonny.app/"; }
        { path = "/Applications/VMware Fusion.app/"; }
        { path = "/Applications/VSCodium.app/"; }

        #{
        #  path = toString myEmacsLauncher;
        #  section = "others";
        #}
        #{
        #  path = "${config.users.users.${user}.home}/.local/share/";
        #  section = "others";
        #  options = "--sort name --view grid --display folder";
        #}
        #{
        #  path = "${config.users.users.${user}.home}/downloads";
        #  section = "others";
        #  options = "--sort name --view grid --display Folder";
        #}
      ];
    };
  };
}

