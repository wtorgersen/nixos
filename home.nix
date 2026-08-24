{ config, lib,  pkgs, stablePkgs,... }:

{
  home.username = "william";
  home.homeDirectory = "/home/william";

  home.stateVersion = "26.05"; # Please read the comment before changing.
  
  gtk = {
  enable = true;
    theme = {
      name = "Adwaita";
      package = pkgs.gnome-themes-extra;
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  dconf.enable = true;
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      #gtk-theme = "Adwaita-dark";
      gtk-theme = "Adwaita";
      color-scheme = "prefer-dark";
    };
  };

  # Packages
  nixpkgs.config.allowUnfree = true;
  home.packages = [
    pkgs.alacritty
    pkgs.brave
    pkgs.cosmic-ext-calculator
    pkgs.eza
    stablePkgs.joplin-desktop
    stablePkgs.keepassxc
    pkgs.libreoffice-fresh
    pkgs.loupe
    pkgs.newsboat
    pkgs.remmina
    pkgs.signal-desktop
    pkgs.gnutar
    pkgs.vlc

    # Programming
    pkgs.gcc
    pkgs.gnumake
    pkgs.python3

    # Language servers for use with neovim
    pkgs.pyright
    pkgs.lua-language-server
    pkgs.tree-sitter

    # Language formatters
    pkgs.prettier
    pkgs.ruff
    pkgs.stylua

  ];

  home.file = {
    ".config/nixpkgs/config.nix".text = ''
    {
      allowUnfree = true;
      allowUnfreePredicate = pkg: true;
    }
    '';
    
    ".config/nvim" = {
      source = ./config/nvim;
      recursive = true;
    };
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Git config
  programs.git = {
        enable = true;
	settings = {
          user.name = "William Torgersen";
          user.email = "william_torgersen@hotmail.com";
          init.defaultBranch = "main";
	};
      };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    initContent  = ''
    autoload -U colors && colors
    export PATH="$HOME/.local/bin:$PATH"
    export PATH="$HOME/Scripts:$PATH"

    bindkey '^R' history-incremental-search-backward

    PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
    '';

    sessionVariables = {
      EDITOR = "nvim";
      GIT_EDITOR = "nvim";
      MANPAGER = "nvim +Man!";
    };

    shellAliases = {
      ls = "eza --icons --group-directories-first";
      l = "eza --icons -a --group-directories-first";
      v = "nvim";
      vim = "nvim";
    };
  };

  programs.neovim = {
    enable = true;
    initLua = lib.fileContents ./config/nvim/init.lua;
  };

}
