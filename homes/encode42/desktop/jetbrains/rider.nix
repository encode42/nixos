{
  flakeLib,
  pkgs,
  ...
}:

{
  home.packages = [
    (flakeLib.customJetbrainsPackage {
      idePackage = pkgs.jetbrains.rider;

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
