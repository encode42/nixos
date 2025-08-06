{
  lib,
  flakeRoot,
  pkgs,
  ...
}:

{
  imports = [
    (flakeRoot + /packages/common/fish.nix)
    (flakeRoot + /packages/common/git.nix)
    (flakeRoot + /packages/common/yubikey.nix)

    (flakeRoot + /packages/desktop/gnome/goldwarden.nix)
    (flakeRoot + /packages/desktop/gnome/localsend.nix)

    (flakeRoot + /packages/desktop/steam.nix)
  ];

  users.users.encode42 = {
    isNormalUser = true;

    shell = pkgs.fish;
  };

  home-manager.users.encode42 = {
    imports = [
      ../homes/encode42.nix
    ];

    programs.home-manager.enable = true;

    home.stateVersion = "24.05";
  };

  users.users.encode42.extraGroups = [
    "wheel"
    "networkmanager"
  ];
}
