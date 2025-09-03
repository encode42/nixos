{ ... }@inputs:

let
  mkSystem = import ./lib/mkSystem.nix {
    inherit inputs;

    flakeRoot = ./.;
  };
in
{
  formatter.x86_64-linux = inputs.nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;

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
  };
}
