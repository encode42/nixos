{
  boot = {
    kernelParams = [ "boot.shell_on_fail" ];

    kernel.sysctl."kernel.sysrq" = 1;
  };
}
