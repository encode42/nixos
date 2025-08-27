{
  inputs,
  flakeRoot,
}:

{
  name,
  system,
  isLaptop ? false,
}:

let
  pkgs = import inputs.nixpkgs {
    inherit system;

    config.allowUnfree = true;
  };

  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit system;

    config.allowUnfree = true;
  };

  flakeLib = import ./default.nix {
    inherit pkgs;

    nix-jetbrains-plugins = inputs.nix-jetbrains-plugins;
  };
in
inputs.nixpkgs.lib.nixosSystem {
  inherit system;

  modules = [
    inputs.lix-module.nixosModules.default
    inputs.disko.nixosModules.disko

    ../hosts/${name}
  ];

  specialArgs = {
    inherit
      flakeRoot
      flakeLib
      pkgs
      pkgs-unstable
      isLaptop
      ;

    lanzaboote = inputs.lanzaboote;
    nixos-hardware = inputs.nixos-hardware;
    home-manager = inputs.home-manager;
    firefox-addons = inputs.firefox-addons;
    nixcord = inputs.nixcord;
  };
}
