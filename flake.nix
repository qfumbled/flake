{
  description = "TODO";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    jovian = {
      url = "github:jovian-experiments/jovian-nixos/development";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lsfg-vk-flake = {
      url = "github:pabloaul/lsfg-vk-flake/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    plasma-manager,
    jovian,
    lsfg-vk-flake,
    nixos-hardware,
    lanzaboote,
    ...
  }: {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/laptop
          home-manager.nixosModules.home-manager
          lanzaboote.nixosModules.lanzaboote
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.xoc = import ./home/laptop;
            home-manager.sharedModules = [plasma-manager.homeManagerModules.plasma-manager];
          }
        ];
      };

      deck = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/deck
          lsfg-vk-flake.nixosModules.default
          jovian.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.xoc = import ./home/deck;
            home-manager.sharedModules = [plasma-manager.homeManagerModules.plasma-manager];
          }
        ];
        specialArgs = { inherit jovian; };
      };
    };
  };
}
