{ config, pkgs, ... }:

{
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = false;

  boot.zfs.devNodes = "/dev/disk/by-partuuid";

  services.zfs.autoScrub.enable = true;

  services.sanoid = {
    enable = true;

    templates = {
      vital = {
        autosnap = true;
        autoprune = true;

        yearly = 3;
        monthly = 12;
        daily = 62;
        hourly = 120;
      };

      hourly = {
        autosnap = true;
        autoprune = true;

        monthly = 3;
        daily = 7;
        hourly = 24;
      };

      daily = {
        autosnap = true;
        autoprune = true;

        monthly = 6;
        daily = 31;
      };
    };
  };
}
