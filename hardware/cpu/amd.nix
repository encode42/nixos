{ nixos-hardware, ... }:

{
  imports = [
    ./common.nix

    nixos-hardware.nixosModules.common-cpu-amd
  ];
}
