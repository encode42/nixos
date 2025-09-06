{ config, ... }:

{
  imports = [
    ../databases/redis.nix
  ];

  services.redis.servers.rspamd = {
    enable = true;

    port = 0;

    user = config.services.rspamd.user;
  };

  services.rspamd = {
    enable = true;

    locals = {
      "redis.conf".text = ''
        servers = "${config.services.redis.servers.rspamd.unixSocket}";
      '';

      "classifier-bayes.conf".text = ''
        backend = "redis";
        autolearn = true;
      '';
    };
  };
}
