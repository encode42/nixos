{
  flakeRoot,
  home-manager,
  pkgs,
  pkgs-unstable,
  ...
}:

{
  imports = [
    home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;

    backupFileExtension = "bak";

    extraSpecialArgs = {
      inherit flakeRoot pkgs pkgs-unstable;
    };
  };

  environment.systemPackages = with pkgs; [
    home-manager
  ];
}
