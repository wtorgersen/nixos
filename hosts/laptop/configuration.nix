{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Networking
  networking.hostName = "nixos-yoga"; # Define your hostname.
  
  # Login / Display manager
  services.displayManager.cosmic-greeter.enable = true;

  # Cosmic Desktop
  services.desktopManager.cosmic.enable = true;

  system.stateVersion = "26.05"; # Did you read the comment?

}
