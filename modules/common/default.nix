{
  imports = [
    ./locale/en_US.nix

    ./network/firewall.nix

    ./system/coreutils.nix
    ./system/firmware.nix
    ./system/memory.nix
    ./system/sudo.nix

    ./home-manager.nix
    ./nix.nix
  ];
}
