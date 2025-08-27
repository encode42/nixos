{
  nixcord,
  firefox-addons,
  ...
}:

{
  imports = [
    ../common/home-manager.nix
  ];

  home-manager = {
    sharedModules = [
      nixcord.homeModules.nixcord
    ];

    extraSpecialArgs = {
      inherit firefox-addons;
    };
  };
}
