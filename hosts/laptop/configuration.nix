# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Networking
  networking.hostName = "nixos-yoga"; # Define your hostname.
  
  # Login / Display manager
  services.displayManager.cosmic-greeter.enable = true;
  #services.displayManager.gdm.enable = true;  
  
  # Enable the GNOME Desktop Environment.
  # services.desktopManager.gnome.enable = true;

  # Cosmic Desktop
  services.desktopManager.cosmic.enable = true;

  system.stateVersion = "26.05"; # Did you read the comment?

}
