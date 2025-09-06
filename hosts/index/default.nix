{
  flakeRoot,
  nixos-hardware,
  pkgs,
  ...
}:

{
  imports = [
    nixos-hardware.nixosModules.common-pc-ssd
    ./hardware-configuration.nix
    (flakeRoot + /hardware/cpu/amd.nix)
    (flakeRoot + /hardware/gpu/amd.nix)

    (flakeRoot + /modules/common)
    (flakeRoot + /modules/common/boot/systemd-boot.nix)

    #(flakeRoot + /modules/server/nfs.nix)
    (flakeRoot + /modules/server/openssh.nix)

    ./config/zfs.nix

    #./config/databases/mysql.nix
    #./config/databases/postgresql.nix

    #./config/groupware/maddy.nix

    #./config/media/audiobookshelf.nix
    #./config/media/emby.nix
    #./config/media/navidrome.nix

    #./config/torrenting/rtorrent.nix
    #./config/torrenting/soulseek.nix

    #./config/web/caddy.nix
    #./config/web/forgejo.nix
    #./config/web/miniflux.nix
    #./config/web/searx.nix
    #./config/web/vaultwarden.nix
    #./config/web/wakapi.nix

    ./users
  ];

  # TODO:
  # - cells
  # - omnipoly

  boot.kernelPackages = pkgs.linuxPackages_hardened;

  time.timeZone = "US/Eastern";

  system.stateVersion = "24.11";
}
