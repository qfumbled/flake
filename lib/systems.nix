{self, ...}: {
  packages.x86_64-linux = {
    laptop = self.nixosConfigurations.laptop.config.system.build.toplevel;
    desktop = self.nixosConfigurations.desktop.config.system.build.toplevel;
    deck = self.nixosConfigurations.deck.config.system.build.toplevel;
  };
}
