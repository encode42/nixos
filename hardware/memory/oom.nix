{
  boot.kernel.sysctl."kernel.sysrq" = 1;

  systemd.oomd = {
    enable = true;
  };
}
