{
  flakeLib,
  pkgs,
  ...
}:

{
  home.packages = [
    (flakeLib.customJetbrainsPackage {
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
