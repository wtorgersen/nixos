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

  # ------------------------------------------------------------
  # SSH
  # ------------------------------------------------------------

  # If SSH should be available on every machine:
  #
  services.openssh = {
    enable = true;
    settings = {
      #PasswordAuthentication = false;
    };
  };


}
