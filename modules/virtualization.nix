{ config, pkgs, ... }:

{
  # ------------------------------------------------------------
  # Virtualization
  # ------------------------------------------------------------  
  #
  programs.virt-manager.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
  };
  virtualisation.spiceUSBRedirection.enable = true;

  # Distrobox
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };
}