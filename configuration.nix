# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.kernelModules = [ "i2c-dev" ];
  
  # Nvidia
  # hardware.graphics.enable = true;
  # services.xserver.videoDrivers = [ "nvidia" ];
  # hardware.nvidia.open = false;

  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older.than 3d";

  # Networking
  networking = {
    hostName = "nixos-yoga"; # Define your hostname.
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

  # Virtualization
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


  # Set your time zone.
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

  i18n.inputMethod = {
    enable = true;
    type = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ /* any engine you want, for example */ anthy ];
  };

  # Login / Display manager
  services.displayManager.cosmic-greeter.enable = true;
  #services.displayManager.gdm.enable = true;  
  
  # Enable the GNOME Desktop Environment.
  services.desktopManager.gnome.enable = true;

  # Cosmic Desktop
  services.desktopManager.cosmic.enable = true;

  # Zsh shell
    programs.zsh = {
      enable = true;
      #syntaxHighlighting.enable = true;
    };
 
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

    programs.dconf.enable = true;
  
    # nm-applet.enable = true;

    # Appimage
    programs.appimage.enable = true;
    programs.appimage.binfmt = true;

  # Fonts
  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.noto-fonts
  ];

  # OpenRGB
  # services.hardware.openrgb.enable = true;
  ## i2c
  # hardware.i2c.enable = true;
  # users.groups.i2c.members = ["william"];


  services = {
    # Configure keymap in X11
    xserver = {
      enable = true;
      xkb.layout = "no";
      xkb.variant = "";
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    syncthing = {
      enable = true;
      user = "william";
      configDir = "/home/william/.config/syncthing";
      dataDir ="/home/william/Documents";
      openDefaultPorts = true;
    };
    libinput.enable = true;
    openssh.enable = true;
    flatpak.enable = true;
    gvfs.enable = true;
    pulseaudio.enable = false;
  };

  # Configure console keymap
  console.keyMap = "no";

  # Enable sound with pipewire.
  security.rtkit.enable = true;

  # Enable Bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;
  
  # Set default shell to Bash
  users.defaultUserShell = pkgs.bashInteractive;

  # Set default shell to zsh
  # users.defaultUserShell = pkgs.zsh;

    # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.william = {
    isNormalUser = true;
    description = "william";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    shell = pkgs.zsh;
    #useDefaultShell = true;
    packages = with pkgs; [
    #  firefox
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty
    blueman
    distrobox
    dnsmasq
    eza
    firefox
    git
    gnome-disk-utility
    htop
    joplin-desktop
    keychain
    neovim
    newsboat
    nwg-look
    pamixer
    pavucontrol
    remmina
    seahorse
    syncthing
    (texliveMedium.withPackages (ps: with ps; [ moderncv ]))
    trash-cli
    #veracrypt
    vim
    vlc
    wget
    zsh
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
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
