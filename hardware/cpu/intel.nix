{
  nixos-hardware,
  isLaptop,
  ...
}:

{
  imports = [
    ./common.nix

    nixos-hardware.nixosModules.common-cpu-intel
  ];

  services.hardware.openrgb.motherboard = "intel";

  services.thermald.enable = isLaptop;
}
