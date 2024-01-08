{ config, pkgs, lib, ... }:

let
  email = "tuna@sodamelon.com";
  user = "tuna";
  name = "Tuna";
  xdg_configHome  = "/home/${user}/.config";
  #shared-programs = import ../shared/home-manager.nix { inherit config pkgs lib; };
  customAliases = import ./aliases.nix { inherit config pkgs lib; };
  shared-files = import ../shared/files.nix { inherit config pkgs; };

#  polybar-user_modules = builtins.readFile (pkgs.substituteAll {
#    src = ./config/polybar/user_modules.ini;
#    packages = "${xdg_configHome}/polybar/bin/check-nixos-updates.sh";
#    searchpkgs = "${xdg_configHome}/polybar/bin/search-nixos-updates.sh";
#    launcher = "${xdg_configHome}/polybar/bin/launcher.sh";
#    powermenu = "${xdg_configHome}/rofi/bin/powermenu.sh";
#    calendar = "${xdg_configHome}/polybar/bin/popup-calendar.sh";
#  });

#  polybar-config = pkgs.substituteAll {
#    src = ./config/polybar/config.ini;
#    font0 = "DejaVu Sans:size=12;3";
#    font1 = "feather:size=12;3"; # from overlay
#  };

#  polybar-modules = builtins.readFile ./config/polybar/modules.ini;
#  polybar-bars = builtins.readFile ./config/polybar/bars.ini;
#  polybar-colors = builtins.readFile ./config/polybar/colors.ini;

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
      #export PATH=$HOME/.pnpm-packages/bin:$HOME/.pnpm-packages:$PATH
      #export PATH=$HOME/.npm-packages/bin:$HOME/bin:$PATH
      export PATH=$HOME/.local/share/bin:$PATH

      # Remove history data we don't want to see
      export HISTIGNORE="pwd:ls:cd"

      POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
      #  Editors
#      export ALTERNATE_EDITOR=""
      export EDITOR="nvim"
      export VISUAL="codium --wait"

#      e() {
#          emacsclient -t "$@"
#      }

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

  # Use a dark theme
  #gtk = {
  #  enable = true;
  #  iconTheme = {
  #    name = "Adwaita-dark";
  #    package = pkgs.gnome.adwaita-icon-theme;
  #  };
  #  theme = {
  #    name = "Adwaita-dark";
  #    package = pkgs.gnome.adwaita-icon-theme;
  #  };
  #};

  # Screen lock
#  services = {
#    screen-locker = {
#      enable = true;
#      inactiveInterval = 10;
#      lockCmd = "${pkgs.i3lock-fancy-rapid}/bin/i3lock-fancy-rapid 10 15";
#    };

    # Auto mount devices
#    udiskie.enable = true;

#    polybar = {
#      enable = true;
#      config = polybar-config;
#      extraConfig = polybar-bars + polybar-colors + polybar-modules + polybar-user_modules;
#      package = pkgs.polybarFull;
#      script = "polybar main &";
#    };

#    dunst = {
#      enable = true;
#      package = pkgs.dunst;
#      settings = {
#        global = {
#          monitor = 0;
#          follow = "mouse";
#          border = 0;
#          height = 400;
#          width = 320;
#          offset = "33x65";
#          indicate_hidden = "yes";
#          shrink = "no";
#          separator_height = 0;
#          padding = 32;
#          horizontal_padding = 32;
#          frame_width = 0;
#          sort = "no";
#          idle_threshold = 120;
#          font = "Noto Sans";
#          line_height = 4;
#          markup = "full";
#          format = "<b>%s</b>\n%b";
#          alignment = "left";
#          transparency = 10;
#          show_age_threshold = 60;
#          word_wrap = "yes";
#          ignore_newline = "no";
#          stack_duplicates = false;
#          hide_duplicate_count = "yes";
#          show_indicators = "no";
#          icon_position = "left";
#          icon_theme = "Adwaita-dark";
#          sticky_history = "yes";
#          history_length = 20;
#          history = "ctrl+grave";
#          browser = "google-chrome-stable";
#          always_run_script = true;
#          title = "Dunst";
#          class = "Dunst";
#          max_icon_size = 64;
#        };
#      };
#    };
#  };

#  programs = shared-programs // { gpg.enable = false; };

}
