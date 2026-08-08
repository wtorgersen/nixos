# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;
  # Use provided UUIDs instead of blkid probing (required for btrfs subvolumes)
  boot.loader.grub.fsIdentifier = "provided";
  

  # Networking
  networking.hostName = "nixos";


  # Login / Display manager
  services.displayManager.gdm.enable = true;  
  
  # Enable the GNOME Desktop Environment.
  services.desktopManager.gnome.enable = true;
  services.gnome.gnome-remote-desktop.enable = true;
  systemd.services.gnome-remote-desktop = {
    wantedBy = [ "graphical.target" ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # blah
  ];

  environment.sessionVariables = rec {
    #BROWSER = "firefox";
    #FILEMANAGER = "thunar";
    #TERMINAL = "cosmic-terminal";
    #ALT_TERMINAL = "alacritty";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  system.stateVersion = "26.05"; # Did you read the comment?

}
