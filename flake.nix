{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, here using the nixos-26.05 branch
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    # The host with the hostname `my-nixos` will use this configuration
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    
    nixosConfigurations = {
    nixos-yoga = lib.nixosSystem {
      inherit system;
      modules = [ ./configuration.nix ];
    };
    };

    homeConfigurations = {
      william = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ]; 
      };
    };
    };
}

