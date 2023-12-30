{ pkgs }:

with pkgs; [
  # General packages for development and system management
<<<<<<< HEAD
  act
  alacritty
  aspell
  aspellDicts.en
  bash-completion
  bat
=======
#  act
  alacritty
#  aspell
#  aspellDicts.en
  bash-completion
#  bat
>>>>>>> 83fa02a (Set up mac initially)
  btop
  coreutils
  killall
  neofetch
  openssh
<<<<<<< HEAD
  pandoc
  sqlite
=======
#  pandoc
#  sqlite
>>>>>>> 83fa02a (Set up mac initially)
  wget
  zip

  # Encryption and security tools
  age
  age-plugin-yubikey
  gnupg
  libfido2
  pinentry
  yubikey-manager

  # Cloud-related tools and SDKs
  #
  # docker marked broken as of Nov 15, 2023
  # https://github.com/NixOS/nixpkgs/issues/267685
  #
  # docker
  # docker-compose
  #
<<<<<<< HEAD
  awscli2
  flyctl
  ngrok
  tflint

  # Media-related packages
  emacs-all-the-icons-fonts
  dejavu_fonts
=======
#  awscli2
#  flyctl
#  ngrok
#  tflint

  # Media-related packages
#  emacs-all-the-icons-fonts
#  dejavu_fonts
>>>>>>> 83fa02a (Set up mac initially)
  ffmpeg
  fd
  font-awesome
  hack-font
  noto-fonts
  noto-fonts-emoji
  meslo-lgs-nf

  # Node.js development tools
<<<<<<< HEAD
  nodePackages.nodemon
  nodePackages.prettier
  nodePackages.npm # globally install npm
  nodejs

  # Text and terminal utilities
  htop
  hunspell
  iftop
  jetbrains-mono
  jq
  ripgrep
  tree
=======
#  nodePackages.nodemon
#  nodePackages.prettier
#  nodePackages.npm # globally install npm
#  nodejs

  # Text and terminal utilities
  htop
#  hunspell
  iftop
  jetbrains-mono
#  jq
#  ripgrep
#  tree
>>>>>>> 83fa02a (Set up mac initially)
  tmux
  unrar
  unzip
  zsh-powerlevel10k

  # Python packages
<<<<<<< HEAD
  python39
  python39Packages.virtualenv # globally install virtualenv
]
=======
#  python311
#  python311Packages.virtualenv # globally install virtualenv
]
>>>>>>> 83fa02a (Set up mac initially)
