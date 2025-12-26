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
    # TODO: Possible to only import these modules when needed?
    sharedModules = [
      nixcord.homeModules.nixcord
    ];

    extraSpecialArgs = {
      inherit firefox-addons;
    };
  };
}
