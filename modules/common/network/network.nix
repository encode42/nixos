{
  networking.networkmanager = {
    enable = true;

    dns = "systemd-resolved";

    wifi = {
      backend = "iwd";

      powersave = true;
    };
  };
}
