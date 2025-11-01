{
  flakeRoot,
  ...
}:

{
  imports = [
    ../config/games.nix

    (flakeRoot + /users/encode42/common)
    (flakeRoot + /users/encode42/desktop/environments/gnome.nix)

    (flakeRoot + /packages/desktop/gnome/localsend.nix)
  ];

  home-manager.users.encode42 = {
    imports = [
      ../homes/config/games.nix
      ../homes/encode42.nix
    ];

    home.stateVersion = "25.05";
  };

  users.users.encode42.extraGroups = [
    "wheel"
    "networkmanager"
  ];
}
