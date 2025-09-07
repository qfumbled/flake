{
  self;
  inputs;
  homeImports;
  ...
}: {
  flake.nixosConfigurations =
    let
      inherit (inputs.nixpkgs.lib) nixosSystem;

      mod =
        "${self}/system";

      desktop =
        import "${self}/system" ./.desktop;

      laptop =
        import "${self}/system" ./.laptop;

      specialArgs =
        {
          inherit inputs;
          inherit self;
        };
    in
    {
      grovetender =
        nixosSystem {
          inherit specialArgs;

          modules =
            desktop
            ++ laptop
            ++ [
              ./grovetender

              "${mod}/programs/gamemode.nix"

              "${mod}/services/gnome-services.nix"

              "${mod}/services/location.nix"

              "${mod}/core/limine.nix"

              {
                home-manager =
                  {
                    users.wug.imports =
                      homeImports."grovetender";

                    extraSpecialArgs =
                      specialArgs;
                  };
              }

              inputs.hm.nixosModules.home-manager

              inputs.impermanence.nixosModules.impermanence

              inputs.nix-flatpak.nixosModules.nix-flatpak

              inputs.stylix.nixosModules.stylix

              inputs.agenix.nixosModules.default

              inputs.chaotic.nixosModules.default
            ];
        };
    };
}
