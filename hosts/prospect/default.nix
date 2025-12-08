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
    (flakeRoot + /hardware/audio/pipewire.nix)
    (flakeRoot + /hardware/network/bluetooth.nix)
    (flakeRoot + /hardware/peripherals/rgb.nix)

    (flakeRoot + /modules/common)
    (flakeRoot + /modules/common/boot/systemd-boot.nix)

    (flakeRoot + /modules/desktop)
    (flakeRoot + /modules/desktop/environments/gnome.nix)
    (flakeRoot + /modules/desktop/system/gamemode.nix)

    ./users
  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;

  time.timeZone = "US/Eastern";

  system.stateVersion = "25.05";
}
