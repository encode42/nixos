{
  hosts ? [ ],
}:

{
  config,
  lib,
  flakeLib,
  pkgs,
  pkgs-unstable,
  utils ? pkgs.utils,
  ...
}:

let
  socket = "/run/flood/flood.sock";
in
{
  services.flood = {
    enable = true;

    package = pkgs-unstable.flood;

    extraArgs = [
      "--rtsocket=${config.services.rtorrent.rpcSocket}"
    ];
  };

  # Override service to support listening on sockets
  systemd.services.flood.serviceConfig = {
    ExecStart = lib.mkForce (
      utils.escapeSystemdExecArgs (
        [
          (lib.getExe config.services.flood.package)
          "--port"
          socket
          "--rundir=/var/lib/flood"
        ]
        ++ config.services.flood.extraArgs
      )
    );

    RuntimeDirectory = "flood";
    RuntimeDirectoryMode = "0750";
    UMask = "0007";

    Group = config.users.groups.flood-proxy.name;
  };

  users.groups.flood-proxy = { };

  # Caddy reverse proxy configuration
  users.users.caddy.extraGroups = [ config.users.groups.flood-proxy.name ];

  services.caddy.virtualHosts = flakeLib.mkProxies hosts ''
    reverse_proxy unix/${socket}
  '';
}
