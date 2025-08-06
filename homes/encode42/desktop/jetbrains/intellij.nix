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
      idePackage = pkgs.jetbrains.idea-ultimate;

      pluginIds = [
        "systems.fehn.intellijdirenv"
        "com.liubs.jaredit"
      ];

      patchedPlugins = [
        "catppuccin-theme"
        "-env-files"
        "minecraft-development"
      ];
    })
  ];
}
