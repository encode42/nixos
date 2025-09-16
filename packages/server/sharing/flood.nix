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

    Group = "flood-proxy";
  };

  users.groups.flood-proxy = { };

  users.users.caddy.extraGroups = [ "flood-proxy" ];

  services.caddy.virtualHosts = flakeLib.mkProxies hosts ''
    reverse_proxy unix/${socket}
  '';
}
