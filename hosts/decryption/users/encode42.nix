{
  lib,
  flakeRoot,
  pkgs,
  ...
}:

{
  imports = [
    (flakeRoot + /users/encode42/common)
    (flakeRoot + /users/encode42/desktop/environments/gnome.nix)

    (flakeRoot + /packages/common/yubikey.nix)

    (flakeRoot + /packages/desktop/gnome/goldwarden.nix)
    (flakeRoot + /packages/desktop/gnome/localsend.nix)

    (flakeRoot + /packages/desktop/steam.nix)
  ];

  home-manager.users.encode42 = {
    imports = [
      ../homes/encode42.nix
    ];

    home.stateVersion = "24.05";
  };

  users.users.encode42.extraGroups = [
    "wheel"
    "networkmanager"
  ];
}
