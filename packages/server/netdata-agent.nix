{ pkgs, ... }:

{
  services.netdata = {
    enable = true;

    package = pkgs.netdataCloud;
  };
}
