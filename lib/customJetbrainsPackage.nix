{ nix-jetbrains-plugins, pkgs }:

{
  idePackage,
  pluginIds ? [ ],
  patchedPlugins ? [ ],
}:

let
  marketplacePluginBase =
    nix-jetbrains-plugins.plugins.${pkgs.system}.${idePackage.pname}.${idePackage.version};
  marketplacePluginList = builtins.map (pluginId: marketplacePluginBase.${pluginId}) pluginIds;

  pluginList = patchedPlugins ++ marketplacePluginList;
in
pkgs.jetbrains.plugins.addPlugins idePackage pluginList
