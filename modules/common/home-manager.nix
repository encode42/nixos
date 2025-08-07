{
  flakeRoot,
  home-manager,
  pkgs,
  pkgs-unstable,
  isLaptop,
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
      inherit
        flakeRoot
        pkgs
        pkgs-unstable
        isLaptop
        ;
    };
  };

  environment.systemPackages = with pkgs; [
    home-manager
  ];
}
