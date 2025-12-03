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
    (flakeRoot + /hardware/peripherals/optical.nix)

    (flakeRoot + /modules/common)
    (flakeRoot + /modules/common/boot/systemd-boot.nix)
    (flakeRoot + /modules/common/network/dns.nix)

    (flakeRoot + /modules/server/filesystem/ulimit.nix)
    (flakeRoot + /modules/server/openssh.nix)

    (flakeRoot + /packages/server/iperf.nix)

    ./config/zfs.nix
    ./config/nfs.nix

    ./config/databases/mysql.nix
    ./config/databases/postgresql.nix

    ./config/groupware/cells.nix
    ./config/groupware/maddy.nix

    ./config/media/audiobookshelf.nix
    ./config/media/emby.nix
    ./config/media/navidrome.nix

    ./config/language/omnipoly.nix

    ./config/sharing/prowlarr.nix
    ./config/sharing/rtorrent.nix
    ./config/sharing/soulseek.nix

    ./config/web/caddy.nix
    ./config/web/forgejo.nix
    ./config/web/immich.nix
    ./config/web/miniflux.nix
    ./config/web/searx.nix
    ./config/web/vaultwarden.nix
    #./config/web/wakapi.nix

    ./users
  ];

  boot.kernelPackages = pkgs.linuxPackages_hardened;

  time.timeZone = "US/Eastern";

  system.stateVersion = "24.11";
}
