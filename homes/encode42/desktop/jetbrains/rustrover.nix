{
  flakeLib,
  pkgs,
  ...
}:

{
  home.packages = [
    (flakeLib.customJetbrainsPackage {
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
