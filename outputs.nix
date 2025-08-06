{ ... }@inputs:

let
  mkSystem = import ./lib/mkSystem.nix {
    inherit inputs;

    flakeRootPath = ./.;
  };
in
{
  formatter.x86_64-linux = inputs.nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;

  nixosConfigurations = {
    encryption = mkSystem {
      name = "encryption";
      system = "x86_64-linux";
    };

    decryption = mkSystem {
      name = "decryption";
      system = "x86_64-linux";

      isLaptop = true;
    };
  };
}
