{
  nixos-hardware,
  isLaptop,
  ...
}:

{
  imports = [
    nixos-hardware.nixosModules.common-cpu-intel
  ];

  services.hardware.openrgb.motherboard = "intel";

  services.thermald.enable = isLaptop;
}
