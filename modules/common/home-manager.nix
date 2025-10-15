{
  flakeRoot,
  flakeLib,
  home-manager,
  pkgs,
  pkgs-unstable,
  pkgs-personal,
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
        flakeLib
        pkgs
        pkgs-unstable
        pkgs-personal
        isLaptop
        ;
    };
  };

  environment.systemPackages = with pkgs; [
    home-manager
  ];
}
