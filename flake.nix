{
  description = "My flake";

  inputs = {
    # Stable NixOS
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    # Unstable NixOS
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Stable Home Manager
    home-manager-stable.url =
      "github:nix-community/home-manager/release-26.05";
    home-manager-stable.inputs.nixpkgs.follows = "nixpkgs";

    # Unstable Home Manager
    home-manager-unstable.url =
      "github:nix-community/home-manager/master";
    home-manager-unstable.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager-stable,
    home-manager-unstable,
    ...
  }:
    let
      system = "x86_64-linux";
      stablePkgs = nixpkgs.legacyPackages.${system};
      unstablePkgs = nixpkgs-unstable.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        laptop = nixpkgs-unstable.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit stablePkgs;
          };

          modules = [
            ./modules/common.nix
            ./modules/desktop.nix
            ./modules/laptop.nix
            ./modules/gaming.nix
            ./modules/virtualization.nix
            ./hosts/laptop/hardware-configuration.nix
          ];
        };

        # Uncomment when the workstation exists.
        #
        # workstation = nixpkgs-unstable.lib.nixosSystem {
        #   inherit system;
        #   specialArgs = {
        #     inherit stablePkgs;
        #   };
        #
        #   modules = [
        #     ./modules/common.nix
        #     ./modules/desktop.nix
        #     ./modules/workstation.nix
        #     ./modules/gaming.nix
        #     ./modules/virtualization.nix
        #     ./hosts/workstation/hardware-configuration.nix
        #   ];
        # };

        testing = nixpkgs.lib.nixosSystem {
          inherit system;

          modules = [
            ./modules/common.nix
            ./modules/desktop.nix
            ./modules/testing.nix
            ./hosts/vm/hardware-configuration.nix
          ];
        };

        prx-test1 = nixpkgs.lib.nixosSystem {
          inherit system;

          modules = [
            ./modules/common.nix
            ./modules/server.nix
            ./hosts/prx-test1/configuration.nix
            ./hosts/prx-test1/hardware-configuration.nix
          ];
        };

        # Uncomment when the Docker host exists.
        #
        # docker1 = nixpkgs.lib.nixosSystem {
        #   inherit system;
        #
        #   modules = [
        #     ./modules/common.nix
        #     ./modules/server.nix
        #     ./hosts/docker1/configuration.nix
        #     ./hosts/docker1/hardware-configuration.nix
        #   ];
        # };
      };

      homeConfigurations = {
        "unstable" =
          home-manager-unstable.lib.homeManagerConfiguration {
            pkgs = unstablePkgs;

            extraSpecialArgs = {
              inherit stablePkgs;
            };

            modules = [
              ./home.nix
            ];
          };

        "stable" =
          home-manager-stable.lib.homeManagerConfiguration {
            pkgs = stablePkgs;

            modules = [
              ./home.nix
            ];
          };
      };
    };
}

