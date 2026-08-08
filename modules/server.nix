{ config, lib, ... }:

{
  options.vmNetwork = {
    interface = lib.mkOption {
      type = lib.types.str;
      default = "ens18";
      description = "Network interface used by the VM.";
    };

    address = lib.mkOption {
      type = lib.types.str;
      description = "Static IPv4 address with prefix length.";
      example = "192.168.1.100/24";
    };

    gateway = lib.mkOption {
      type = lib.types.str;
      description = "IPv4 default gateway.";
      example = "192.168.1.1";
    };

    nameservers = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [
        "1.1.1.1"
        "8.8.8.8"
      ];
      description = "IPv4 DNS nameservers.";
    };
  };

  config = {
    networking.useNetworkd = true;
    systemd.network.enable = true;

    systemd.network.networks."10-static-ip" = {
      matchConfig.Name = config.vmNetwork.interface;

      networkConfig = {
        DHCP = "no";
        IPv6AcceptRA = false;
      };

      address = [
        config.vmNetwork.address
      ];

      routes = [
        {
          Gateway = config.vmNetwork.gateway;
        }
      ];
    };

    networking.nameservers = config.vmNetwork.nameservers;

    services.qemuGuest.enable = true;

    services.openssh = {
      enable = true;
      settings = {
        # PasswordAuthentication = false;
      };
    };
  };
}
