{
  hosts ? [ ],
  interface ? "",
}:

{ config, flakeLib, ... }:

{
  services.slskd = {
    enable = true;

    domain = null;

    settings = {
      # Upload limits assume a fast connection
      global = {
        upload = {
          slots = 75;
          speed_limit = 122070;
        };
      };

      groups.default = {
        upload = {
          slots = 50;
          speed_limit = 12207;
        };

        limits.queued = {
          files = 300;
          megabytes = 5000;
        };

        limits.daily = {
          files = 2147483647;
          megabytes = 2147483647;
        };

        limits.weekly = {
          files = 2000;
          megabytes = 30000;
        };
      };

      groups.leechers = {
        thresholds = {
          files = 25;
          directories = 3;
        };

        upload = {
          slots = 3;
          speed_limit = 976;
        };

        limits.queued = {
          files = 30;
          megabytes = 1000;
        };

        limits.daily = {
          files = 30;
          megabytes = 1000;
        };

        limits.weekly = {
          files = 150;
          megabytes = 5000;
        };
      };

      shares = {
        # These files can contain sensitive information
        filters = [
          ".md$"
          ".log$"
          ".pydio$"
        ];

        # Assumes a more powerful machine
        cache = {
          storage_mode = "memory";
          workers = 8;
          retention = 10080;
        };
      };

      filters.search.request = [
        "^.{1,2}$"
        "^(\.?pdf|\.?docx|\.?xlsx)$"
      ];

      # Numbers are measured in hours
      retention = {
        search = 5; # Users go offline often, invalidating search

        transfers = {
          upload = {
            succeeded = 10080;
            errored = 1440;
            cancelled = 1440;
          };

          download = {
            succeeded = 1440;
            errored = 10080;
            cancelled = 10080;
          };
        };
      };
    };
  };

  services.caddy.virtualHosts = flakeLib.mkProxies hosts ''
    reverse_proxy ${interface}:${toString config.services.slskd.settings.web.port} {
      header_up Upgrade "websocket"
      header_up Connection "Upgrade"
    }
  '';
}
