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

    (flakeRoot + /modules/common)
    (flakeRoot + /modules/common/boot/secureboot.nix)
    (flakeRoot + /modules/common/system/audio.nix)
    (flakeRoot + /modules/common/virtualization.nix)

    (flakeRoot + /modules/desktop/environments/gnome.nix)

    ./users
  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;

  time.timeZone = "US/Eastern";

  networking.hostName = "encryption";

  system.stateVersion = "24.05";
}
