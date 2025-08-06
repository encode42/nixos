{
  flakeRoot,
  nix-jetbrains-plugins,
  pkgs,
  ...
}:

let
  customJetbrainsPackage = import (flakeRoot + /lib/customJetbrainsPackage.nix) {
    inherit nix-jetbrains-plugins pkgs;
  };
in
{
  home.packages = [
    (customJetbrainsPackage {
      idePackage = pkgs.jetbrains.rust-rover;

      pluginIds = [
        "systems.fehn.intellijdirenv"
      ];

      patchedPlugins = [
        "catppuccin-theme"
        "-env-files"
      ];
    })
  ];
}
