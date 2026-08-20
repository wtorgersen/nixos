
{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [
    "i2c-dev"
    "i2c-piix4"
  ];

  # Firmware
  hardware.enableRedistributableFirmware = true;

  # Graphics
  services.xserver.videoDrivers = [ "nvidia" ]; # Not sure if this is needed

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    nvidiaSettings = true;
  };
  
  # Networking
  networking.hostName = "nixos-st"; 

  # Login / Display manager
  services.displayManager.cosmic-greeter.enable = true;

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

  environment.systemPackages = with pkgs; [
    handbrake
  ];

  system.stateVersion = "26.05"; # Did you read the comment?
}
