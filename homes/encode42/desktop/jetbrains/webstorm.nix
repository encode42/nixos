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
      idePackage = pkgs.jetbrains.webstorm;

      pluginIds = [
        "systems.fehn.intellijdirenv"
        "com.github.biomejs.intellijbiome"
        "intellij.javascript.bun"
        "dev.blachut.svelte.lang"
      ];

      patchedPlugins = [
        "catppuccin-theme"
        "-env-files"
      ];
    })
  ];
}
