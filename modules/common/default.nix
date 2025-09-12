{
  imports = [
    ./nfs.nix

    ./locale/en_US.nix

    ./network/firewall.nix
    ./network/network.nix
    ./network/ssh.nix

    ./system/coreutils.nix
    ./system/firmware.nix
    ./system/memory.nix
    ./system/sudo.nix

    ./home-manager.nix
    ./nix.nix
  ];
}
