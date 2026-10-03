# Common configuration shared by all NixOS desktop systems.
#
# This module should contain settings that make sense on:
#   - laptops
#   - workstations
#
# Machine-specific configuration belongs in the respective host/module.

{ config, pkgs, stablePkgs, ... }:

{
  services.libinput.enable = true;
  
  # -----------------------------------------------------------
  # Shell
  # -----------------------------------------------------------
  #
  # Set default shell to Bash
  users.defaultUserShell = pkgs.bashInteractive;
  
  # Zsh shell
    programs.zsh = {
      enable = true;
      #syntaxHighlighting.enable = true;
    };


  # ------------------------------------------------------------
  # Printing
  # ------------------------------------------------------------
  #
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      cups-filters
      cups-browsed
      brlaser
    ];
  };
  
  # ------------------------------------------------------------
  # Sound support
  # ------------------------------------------------------------
  #
  security.rtkit.enable = true; # Allow pipewire to use realtime scheduler.
  
  services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
  };

  # ------------------------------------------------------------
  # Syncthing
  # ------------------------------------------------------------
  #
  services.syncthing = {
    enable = true;
    user = "william";
    configDir = "/home/william/.config/syncthing";
    dataDir ="/home/william/Documents";
    openDefaultPorts = true;
  };
  
  # ------------------------------------------------------------
  # Common desktop packages
  # ------------------------------------------------------------
  #
  # Appimage support
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  # Flatpak support
  services.flatpak.enable = true;
  # Fonts
  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.noto-fonts
  ];

  # Virus scanning
  services.clamav = {
    # daemon.enable = true;
    updater.enable = true;
  };

  environment.systemPackages = with pkgs; [
    blueman
    cifs-utils
    clamav
    distrobox
    dnsutils
    dnsmasq
    firefox
    gimp
    gnome-disk-utility
    pamixer
    pavucontrol
    seahorse
    syncthing
    (texliveMedium.withPackages (ps: with ps; [ moderncv ]))
    trash-cli
    virt-viewer
    zsh
    
    # Emacs deps
    ripgrep
    fd
    libvterm
  ];


  # ------------------------------------------------------------
  # Networking
  # ------------------------------------------------------------
  #
  services.gvfs.enable = true;
  
  # Networking
  networking = {
    networkmanager.enable = true;

    # Firewall
    nftables.enable = true;

    firewall = {
      enable = true;
      trustedInterfaces = ["virbr0"];
      allowedTCPPortRanges = [
        { from = 5900; to = 6000; } # SPICE Virt-manager
      ];
    };
  };
  
  # ------------------------------------------------------------
  # SSH
  # ------------------------------------------------------------

  # If SSH should be available on every machine:
  #
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "william" ];
    };
  };

  
  # ------------------------------------------------------------
  # Bluetooth
  # ------------------------------------------------------------
  #
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;


  # ------------------------------------------------------------
  # Common users
  # ------------------------------------------------------------
  users.users.william = {
    extraGroups = [ "networkmanager" "libvirtd" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL7fXELxxUaM8OiLhtmlYqT4y7McAMk2SZ2o3jlTDcFd"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAMPF013m7oLC+8O/rNLQv1sHqlX3V896m5YRWH9/tX+"
    ];
  };

  # ------------------------------------------------------------
  # Miscellaneous
  # ------------------------------------------------------------

}
