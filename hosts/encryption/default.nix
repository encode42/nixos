{
  flakeRoot,
  nixos-hardware,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    nixos-hardware.nixosModules.msi-b350-tomahawk
    (flakeRoot + /hardware/cpu/amd.nix)
    (flakeRoot + /hardware/gpu/amd.nix)

    ./users

    (flakeRoot + /modules/common)

    (flakeRoot + /modules/common/boot/secureboot.nix)
    (flakeRoot + /modules/common/system/audio.nix)
    (flakeRoot + /modules/desktop/environments/gnome.nix)

    (flakeRoot + /modules/common/virtualization.nix)
  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;

  networking.hostName = "encryption";

  system.stateVersion = "24.05";
}
