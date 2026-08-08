# Common configuration shared by all NixOS systems.
#
# This module should contain settings that make sense on:
#   - laptops
#   - workstations
#   - servers / VMs
#
# Machine-specific configuration belongs in the respective host/module.

{ config, pkgs, ... }:

{
  networking.hostName = "prx-test1";

  vmNetwork = {
    address = "10.10.100.25/24";
    gateway = "10.10.100.1";

    nameservers = [
      "10.10.100.1"
      "1.1.1.1"
    ];
  };

  system.stateVersion = "26.05"; # Did you read the comment?

}
