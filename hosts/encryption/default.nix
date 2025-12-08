{
  flakeRoot,
  nixos-hardware,
  pkgs,
  ...
}:

{
  imports = [
    nixos-hardware.nixosModules.msi-b350-tomahawk
    nixos-hardware.nixosModules.common-pc-ssd
    ./hardware-configuration.nix
    (flakeRoot + /hardware/cpu/amd.nix)
    (flakeRoot + /hardware/gpu/amd.nix)
    (flakeRoot + /hardware/audio/pipewire.nix)
    (flakeRoot + /hardware/audio/noise-cancellation.nix)
    (flakeRoot + /hardware/peripherals/xr1.nix)

    (flakeRoot + /modules/common)
    (flakeRoot + /modules/common/boot/secureboot.nix)
    (flakeRoot + /modules/common/virtualization.nix)

    (flakeRoot + /modules/desktop)
    (flakeRoot + /modules/desktop/environments/gnome.nix)
    (flakeRoot + /modules/desktop/system/gamemode.nix)

    ./users
  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;

  time.timeZone = "US/Eastern";

  system.stateVersion = "24.05";
}
