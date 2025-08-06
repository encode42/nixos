{
  lib,
  nixos-hardware,
  isLaptop,
  ...
}:

{
  imports = [
    ./common.nix

    nixos-hardware.nixosModules.common-cpu-intel
  ];

  services.thermald.enable = isLaptop;
}
