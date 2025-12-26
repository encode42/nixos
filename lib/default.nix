{
  nix-jetbrains-plugins,
  pkgs,
  lib,
}:

{
  customJetbrainsPackage = import ./customJetbrainsPackage.nix {
    inherit nix-jetbrains-plugins pkgs;
  };

  mkPegasus = import ./mkPegasus.nix { inherit pkgs lib; };
  mkProxies = import ./mkProxies.nix { inherit lib; };
  mkShares = import ./mkShares.nix { inherit lib; };
  mkUserIcon = import ./mkUserIcon.nix;
}
