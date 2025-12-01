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

  users.users.encode42 = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM0jCVfIbVcgHOoDC8aUHDwUJu2mEqzvnqz3+9IeLhBO"
    ];

    extraGroups = [
      "wheel"
      "cdrom"
      "optical"

      "media"
    ];
  };
}
