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
    (flakeRoot + /hardware/gpu/nvidia.nix)
    (flakeRoot + /hardware/memory/oom.nix)
    (flakeRoot + /hardware/audio/pipewire.nix)
    (flakeRoot + /hardware/network/wifi.nix)
    (flakeRoot + /hardware/network/bluetooth.nix)

    (flakeRoot + /modules/common)
    (flakeRoot + /modules/common/boot/secureboot.nix)

    (flakeRoot + /modules/desktop/environments/gnome.nix)

    ./users
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.nvidia.prime = {
    amdgpuBusId = "PCI:4:0:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  system.stateVersion = "25.05";
}
