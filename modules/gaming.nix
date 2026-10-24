{ config, pkgs, ... }:

{
  # ------------------------------------------------------------
  # Gaming
  # ------------------------------------------------------------
  #
  # Steam
    programs.steam.package = pkgs.steam.override {
      extraPkgs = pkgs': with pkgs'; [
      libxcursor
      libxi
      libxinerama
      libxscrnsaver
      libpng
      libpulseaudio
      libvorbis
      stdenv.cc.cc.lib # Provides libstdc++.so.6
      libkrb5
      keyutils
      # Add other libraries as needed
      ];
    };
   
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };

    services.udev.packages = with pkgs; [ 
      game-devices-udev-rules 
    ];

    # Sunshine game streaming
    services.sunshine = {
      enable = true;
      autoStart = false;
      capSysAdmin = true; # only needed for Wayland -- omit this when using with Xorg
      openFirewall = true;
    };

    hardware.uinput.enable = true;
    users.users.william  = {
      extraGroups = [ "uinput" ];
    };
}
