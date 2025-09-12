{
  inputs,
  flakeRoot,
}:

{
  hostName,
  system,
  extraModules ? [ ],
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

  pkgs-personal = import inputs.encode42-packages {
    inherit system;
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

    ../hosts/${hostName}

    {
      networking.hostName = hostName;
    }
  ]
  ++ builtins.attrValues inputs.encode42-packages.nixosModules
  ++ inputs.nixpkgs.lib.optional isLaptop ../hardware/laptop.nix
  ++ extraModules;

  specialArgs = {
    inherit
      flakeRoot
      flakeLib
      pkgs
      pkgs-unstable
      pkgs-personal
      isLaptop
      hostName
      ;

    lanzaboote = inputs.lanzaboote;
    nixos-hardware = inputs.nixos-hardware;
    home-manager = inputs.home-manager;
    firefox-addons = inputs.firefox-addons;
    nixcord = inputs.nixcord;
    emby-flake = inputs.emby-flake;
  };
}
