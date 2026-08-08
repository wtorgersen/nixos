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
}