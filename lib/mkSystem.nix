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

  pkgs-personal = inputs.encode42-packages.packages.${system};

  pkgs-hexadecimalDinosaur = import inputs.hexadecimalDinosaur-packages {
    inherit pkgs;
  };

  pkgs-winboat = import inputs.nixpkgs-winboat {
    inherit system;
  };

  lib = inputs.nixpkgs.lib;

  flakeLib = import ./default.nix {
    inherit pkgs lib;

    nix-jetbrains-plugins = inputs.nix-jetbrains-plugins;
  };
in
lib.nixosSystem {
  inherit system;

  modules = [
    inputs.lix-module.nixosModules.default
    inputs.disko.nixosModules.disko

    ../hosts/${hostName}

    {
      nixpkgs.pkgs = pkgs;

      networking.hostName = hostName;
    }
  ]
  ++ builtins.attrValues inputs.encode42-packages.nixosModules
  ++ lib.optional isLaptop ../hardware/laptop.nix
  ++ extraModules;

  specialArgs = {
    inherit
      flakeRoot
      flakeLib
      pkgs-unstable
      pkgs-personal
      pkgs-hexadecimalDinosaur
      pkgs-winboat
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
