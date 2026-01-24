{
  flakeLib,
  pkgs,
  ...
}:

{
  home.packages = [
    (flakeLib.customJetbrainsPackage {
      idePackage = pkgs.jetbrains.idea-oss;

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
