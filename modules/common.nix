# Common configuration shared by all NixOS systems.
#
# This module should contain settings that make sense on:
#   - laptops
#   - workstations
#   - servers / VMs
#
# Machine-specific configuration belongs in the respective host/module.

{ config, pkgs, ... }:

{
  # ------------------------------------------------------------
  # Nix
  # ------------------------------------------------------------

  nix.settings = {
    # Enable flakes and the new nix CLI.
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    # Optional: allow your user(s) to use the Nix daemon.
    trusted-users = [ "@wheel" ];
  };

  # Automatic garbage collection.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 3d";
  };

  # Optional: optimise the Nix store automatically.
  # This deduplicates identical files in the store.
  nix.optimise.automatic = true;


  # ------------------------------------------------------------
  # Common packages
  # ------------------------------------------------------------
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    htop
    tree
  ];


  # ------------------------------------------------------------
  # Networking
  # ------------------------------------------------------------


  # ------------------------------------------------------------
  # Time zone / locale
  # ------------------------------------------------------------

  time.timeZone = "Europe/Oslo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nb_NO.UTF-8";
    LC_IDENTIFICATION = "nb_NO.UTF-8";
    LC_MEASUREMENT = "nb_NO.UTF-8";
    LC_MONETARY = "nb_NO.UTF-8";
    LC_NAME = "nb_NO.UTF-8";
    LC_NUMERIC = "nb_NO.UTF-8";
    LC_PAPER = "nb_NO.UTF-8";
    LC_TELEPHONE = "nb_NO.UTF-8";
    LC_TIME = "nb_NO.UTF-8";
  };
  
  # Configure console keymap
  console.keyMap = "no";


  # ------------------------------------------------------------
  # Common users
  # ------------------------------------------------------------

  # If the same user exists on every machine, you can define
  # them here.
  #
  users.users.william = {
    isNormalUser = true;
    group = "william";
    description = "William";
    uid = 1000;
    extraGroups = [
      "wheel"
    ];
  };

  users.groups.william = {};

  # ------------------------------------------------------------
  # Miscellaneous
  # ------------------------------------------------------------

}
