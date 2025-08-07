{
  inputs,
  flakeRootPath,
}:

{
  name,
  system,
  isLaptop ? false,
}:

inputs.nixpkgs.lib.nixosSystem {
  inherit system;

  modules = [
    inputs.lix-module.nixosModules.default
    inputs.disko.nixosModules.disko

    ../hosts/${name}
  ];

  specialArgs = {
    inherit isLaptop;

    flakeRoot = flakeRootPath;

    pkgs = import inputs.nixpkgs {
      inherit system;

      config.allowUnfree = true;
    };

    pkgs-unstable = import inputs.nixpkgs-unstable {
      inherit system;

      config.allowUnfree = true;
    };

    lanzaboote = inputs.lanzaboote;
    nixos-hardware = inputs.nixos-hardware;
    home-manager = inputs.home-manager;
    nix-jetbrains-plugins = inputs.nix-jetbrains-plugins;
    firefox-addons = inputs.firefox-addons;
    nixcord = inputs.nixcord;
  };
}
