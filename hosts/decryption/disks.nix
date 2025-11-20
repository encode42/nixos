{
  boot.initrd.systemd.enable = true;

  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-WD_BLACK_SN7100_1TB_251356803910";

        content = {
          type = "gpt";

          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";

              content = {
                type = "filesystem";

                format = "vfat";
                mountpoint = "/boot";
              };
            };

            luks = {
              size = "100%";

              content = {
                name = "cryptroot";
                type = "luks";

                extraOpenArgs = [
                  "--allow-discards"
                  "--perf-no_read_workqueue"
                  "--perf-no_write_workqueue"
                ];

                settings = {
                  crypttabExtraOpts = [
                    "tpm2-device=auto"
                    "token-timeout=10"
                  ];
                };

                content = {
                  type = "lvm_pv";
                  vg = "vg0";
                };
              };
            };
          };
        };
      };
    };

    lvm_vg.vg0 = {
      type = "lvm_vg";

      lvs = {
        root = {
          name = "root";
          size = "100%FREE";

          content = {
            type = "filesystem";

            format = "xfs";
            mountpoint = "/";
          };
        };

        swap = {
          name = "swap";
          size = "32G";

          content = {
            type = "swap";
          };
        };
      };
    };
  };
}
