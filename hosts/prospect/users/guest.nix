{
  lib,
  flakeRoot,
  pkgs,
  ...
}:

{
  imports = [
    ../config/games.nix
  ];

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "guest";

  users.users.guest = {
    isNormalUser = true;
  };

  home-manager.users.guest = {
    imports = [
      ../homes/config/games.nix
      ../homes/guest.nix
    ];

    home.stateVersion = "25.05";
  };
}
