{
  nix-jetbrains-plugins,
  pkgs,
  lib,
}:

{
  customJetbrainsPackage = import ./customJetbrainsPackage.nix {
    inherit nix-jetbrains-plugins pkgs;
  };

  mkProxies = import ./mkProxies.nix { inherit lib; };
  mkShares = import ./mkShares.nix { inherit lib; };
  mkUserIcon = import ./mkUserIcon.nix;
}
