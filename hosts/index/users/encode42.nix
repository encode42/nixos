{
  flakeRoot,
  ...
}:

{
  imports = [
    (flakeRoot + /users/encode42/common)
  ];

  home-manager.users.encode42 = {
    imports = [
      ../homes/encode42.nix
    ];

    home.stateVersion = "25.05";
  };

  users.users.encode42.extraGroups = [
    "wheel"
    "cdrom"
    "optical"

    "media"
  ];
}
