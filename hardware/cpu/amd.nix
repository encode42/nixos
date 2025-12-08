{ nixos-hardware, ... }:

{
  imports = [
    nixos-hardware.nixosModules.common-cpu-amd
  ];

  services.hardware.openrgb.motherboard = "amd";
}
