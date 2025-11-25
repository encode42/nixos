{
  boot = {
    plymouth = {
      enable = true;
    };

    consoleLogLevel = 3;
    kernelParams = [
      "quiet"
      "splash"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];

    initrd.verbose = false;

    loader.timeout = 0;
  };
}
