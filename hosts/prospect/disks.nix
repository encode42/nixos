{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-WD_BLACK_SN7100_1TB_252945801255";

        content = {
          type = "gpt";

          partitions = {
            ESP = {
              end = "500M";
              type = "EF00";

              content = {
                type = "filesystem";

                format = "vfat";
                mountpoint = "/boot";
              };
            };

            root = {
              name = "root";
              end = "-0";

              content = {
                type = "filesystem";

                format = "xfs";
                mountpoint = "/";
              };
            };
          };
        };
      };

      storage = {
        type = "disk";
        device = "/dev/disk/by-id/ata-ST4000DM004-2CV104_ZTT1Y529";

        content = {
          type = "gpt";

          partitions = {
            root = {
              end = "-0";

              content = {
                type = "filesystem";
                format = "xfs";
              };
            };
          };
        };
      };
    };
  };
}
