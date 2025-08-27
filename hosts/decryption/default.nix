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
    ./disk.nix
    (flakeRoot + /hardware/cpu/amd.nix)
    (flakeRoot + /hardware/gpu/nvidia.nix)

    (flakeRoot + /modules/common)
    (flakeRoot + /modules/common/boot/systemd-boot.nix)
    (flakeRoot + /modules/common/system/audio.nix)

    (flakeRoot + /modules/desktop/environments/gnome.nix)

    ./users
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.nvidia.prime = {
    amdgpuBusId = "PCI:4:0:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  networking.hostName = "decryption";

  system.stateVersion = "25.05";
}
