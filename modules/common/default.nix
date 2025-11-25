{
  imports = [
    ./locale/en_US.nix

    ./network/firewall.nix
    ./network/ssh.nix

    ./system/coreutils.nix
    ./system/firmware.nix
    ./system/sudo.nix

    ./home-manager.nix
    ./nix.nix
  ];
}
