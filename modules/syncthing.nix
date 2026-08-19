{ config, pkgs, ... }:

let
  user = "william";
  home = "/home/${user}";

  trashCan = {
    type = "trashcan";
    params.cleanoutDays = "30";
  };
in

{
  services.syncthing = {
    enable = true;

    # Run Syncthing as this user
    user = user;
    group = user;

    # Allow Syncthing's default ports through the NixOS firewall
    openDefaultPorts = true;

    # Make Nix the source of truth for devices and folders
    overrideDevices = true;
    overrideFolders = true;

    settings = {
      options = {
        # Discovery
        globalAnnounceEnabled = false;
        localAnnounceEnabled = true;

        # Connectivity
        relaysEnabled = false;
        natEnabled = true;

        # Listen on IPv4 TCP/22000
        listenAddresses = [
          "tcp4://0.0.0.0:22000"
          "tcp4://:22000"
        ];
      };

      # Remote Syncthing devices
      devices = {
        syncthing02 = {
          id = "SR7VPTD-HL7FOYX-GBNYFPF-HPWWHAE-AGDBII2-IKTIMSK-YLLLYYR-VIJ5NA3";
          addresses = [
            "tcp4://10.0.12.15:22000"
            "tcp4://syncthing02.lv.lan:22000"
          ];
        };
      };

      # Syncthing folders
      folders = {
        ArdourProjects = {
          id = "dwqqf-jau5b";
          label = "ArdourProjects";
          path = "${home}/Music/ArdourProjects";

          devices = [ "syncthing02" ];
          versioning = trashCan;
        };

        Bitwig = {
          id = "ojurt-vvzlo";
          label = "Bitwig";
          path = "${home}/Music/Bitwig";

          devices = [ "syncthing02" ];
          versioning = trashCan;
        };

        Mixdown = {
          id = "npxd4-tkz4o";
          label = "Mixdown";
          path = "${home}/Music/Mixdown";

          devices = [ "syncthing02" ];
          versioning = trashCan;
        };
        
        PictureProjects = {
          id = "jphju-cruag";
          label = "PictureProjects";
          path = "${home}/Pictures/PictureProjects";

          devices = [ "syncthing02" ];
          versioning = trashCan;
        };

        ReaperProjects = {
          id = "74vlz-qw7v5";
          label = "ReaperProjects";
          path = "${home}/Music/ReaperProjects";

          devices = [ "syncthing02" ];
          versioning = trashCan;
        };

        Screenshots = {
          id = "vfju5-qghtt";
          label = "Screenshots";
          path = "${home}/Pictures/Screenshots";

          devices = [ "syncthing02" ];
          versioning = trashCan;
        };

        SyncedDocs = {
          id = "bqgnd-zeyzt";
          label = "SyncedDocs";
          path = "${home}/Documents/SyncedDocs";

          devices = [ "syncthing02" ];
          versioning = trashCan;
        };

        Tools = {
          id = "n2nqu-mjuud";
          label = "Tools";
          path = "${home}/Tools";

          devices = [ "syncthing02" ];
          versioning = trashCan;
        };

        Videos = {
          id = "u3zhi-un4hw";
          label = "Videos";
          path = "${home}/Videos/SyncedVideos";

          devices = [ "syncthing02" ];
          versioning = trashCan;
        };

        Wallpapers = {
          id = "vekxy-u9nvz";
          label = "Wallpapers";
          path = "${home}/Pictures/Wallpapers";

          devices = [ "syncthing02" ];
          versioning = trashCan;
        };

      };
    };
  };
}
