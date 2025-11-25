{
  imports = [
    ./common.nix
  ];

  boot = {
    kernelParams = [ "boot.shell_on_fail" ];

    loader.systemd-boot.enable = true;
  };
}
