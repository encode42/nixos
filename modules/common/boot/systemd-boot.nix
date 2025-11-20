{
  imports = [
    ./common.nix
  ];

  boot.loader.systemd-boot = {
    enable = true;

    editor = false;
    configurationLimit = 6;
  };

  boot.loader.timeout = 0;
}
