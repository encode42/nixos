{
  flakeRoot,
  ...
}:

{
  imports = [
    (flakeRoot + /users/encode42/common)
    (flakeRoot + /users/encode42/desktop/environments/gnome.nix)

    (flakeRoot + /packages/common/yubikey.nix)

    (flakeRoot + /packages/desktop/gnome/localsend.nix)

    (flakeRoot + /packages/desktop/obs.nix)
    (flakeRoot + /packages/desktop/steam.nix)
  ];

  services.displayManager.autoLogin = {
    enable = true;
    user = "encode42";
  };

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  home-manager.users.encode42 = {
    imports = [
      ../homes/encode42.nix
    ];

    home.stateVersion = "24.05";
  };

  users.users.encode42.extraGroups = [
    "wheel"
    "networkmanager"
    "libvirtd"
    "dialout"
  ];
}
