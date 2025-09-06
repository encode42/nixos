{
  hosts ? [ ],
}:

{
  config,
  lib,
  flakeLib,
  pkgs,
  utils ? pkgs.utils,
  ...
}:

let
  socket = "/run/flood/flood.sock";
in
{
  services.flood = {
    enable = true;

    extraArgs = [
      "--rtsocket=${config.services.rtorrent.rpcSocket}"
    ];
  };

  systemd.services.flood.serviceConfig.ExecStart = lib.mkForce (utils.escapeSystemdExecArgs (
    [
      (lib.getExe pkgs.flood)
      "--port ${socket}"
      "--rundir=/var/lib/flood"
    ]
    ++ config.services.flood.extraArgs
  ));

  services.caddy.virtualHosts = flakeLib.mkProxies hosts ''
    reverse_proxy unix/${socket}
  '';
}
