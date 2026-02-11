{ ... }@inputs:

let
  forAllSystems = inputs.nixpkgs.lib.genAttrs inputs.nixpkgs.lib.systems.flakeExposed;

  mkSystem = import ./lib/mkSystem.nix {
    inherit inputs;

    flakeRoot = ./.;
  };
in
{
  formatter = forAllSystems (system: inputs.nixpkgs.legacyPackages.${system}.nixfmt-tree);

  nixosConfigurations = {
    encryption = mkSystem {
      hostName = "encryption";
      system = "x86_64-linux";
    };

    decryption = mkSystem {
      hostName = "decryption";
      system = "x86_64-linux";

      isLaptop = true;
    };

    prospect = mkSystem {
      hostName = "prospect";
      system = "x86_64-linux";
    };

    index = mkSystem {
      hostName = "index";
      system = "x86_64-linux";

      extraModules = [
        inputs.vpn-confinement.nixosModules.default
        inputs.emby-flake.nixosModules.default
        inputs.tangled.nixosModules.knot
        inputs.tangled.nixosModules.spindle
      ];
    };
  };
}
