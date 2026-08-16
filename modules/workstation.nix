# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [
    "i2c-dev"
    "i2c-piix4"
  ];
  
  # Networking
  networking.hostName = "nixos-st"; 

  # Login / Display manager
  services.displayManager.cosmic-greeter.enable = true;
  #services.displayManager.gdm.enable = true;  
  
  # Enable the GNOME Desktop Environment.
  # services.desktopManager.gnome.enable = true;

  # Cosmic Desktop
  services.desktopManager.cosmic.enable = true;

  # OpenRGB
  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb-with-all-plugins;
    motherboard = "amd";
  };

  ## i2c
  hardware.i2c.enable = true;
  users.groups.i2c.members = ["william"];
  
  system.stateVersion = "26.05"; # Did you read the comment?
}
