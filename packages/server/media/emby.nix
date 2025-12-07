{
  hosts ? [ ],
}:

{ lib, flakeLib, emby-flake, ... }:

{
  services.emby = {
    enable = true;

    package = emby-flake.packages.x86_64-linux.default;
  };

  systemd.services.emby = {
    environment = {
      VDPAU_DRIVER = "radeonsi";
      LIBVA_DRIVER_NAME = "radeonsi";
    };

    serviceConfig = {
      StateDirectory = "emby";

      DeviceAllow = [ "/dev/dri/card0" "/dev/dri/renderD128" ];

      SystemCallFilter = lib.mkForce [];

    };
  };

  users.users.emby.extraGroups = [
    "media"
    "render"
    "video"
  ];

  # Caddy reverse proxy configuration
  services.caddy.virtualHosts = flakeLib.mkProxies hosts ''
    reverse_proxy :8096
  '';
}
