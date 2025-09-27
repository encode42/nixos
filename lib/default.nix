{ nix-jetbrains-plugins, pkgs }:

{
  customJetbrainsPackage = import ./customJetbrainsPackage.nix {
    inherit nix-jetbrains-plugins pkgs;
  };

  mkProxies = import ./mkProxies.nix;
  mkUserIcon = import ./mkUserIcon.nix;
}
