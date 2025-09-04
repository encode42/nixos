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
    ./disks.nix
    (flakeRoot + /hardware/cpu/amd.nix)
    (flakeRoot + /hardware/gpu/amd.nix)

    (flakeRoot + /modules/common)
    (flakeRoot + /modules/common/boot/systemd-boot.nix)
    (flakeRoot + /modules/common/system/audio.nix)
    (flakeRoot + /modules/common/system/rgb.nix)

    (flakeRoot + /modules/desktop/environments/gnome.nix)

    ./users
  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;

  time.timeZone = "US/Eastern";

  system.stateVersion = "25.05";
}
