{
  hosts ? [ ],
}:

{
  config,
  pkgs-unstable,
  flakeLib,
  ...
}:

let
  prowlarrModulePath = "services/misc/servarr/prowlarr.nix";
in
{
  disabledModules = [ prowlarrModulePath ];
  imports = [ "${pkgs-unstable.path}/nixos/modules/${prowlarrModulePath}" ];

  services.prowlarr = {
    enable = true;

    # https://wiki.servarr.com/useful-tools#using-environment-variables-for-config
    settings = { };
  };

  services.caddy.virtualHosts = flakeLib.mkProxies hosts ''
    reverse_proxy :${toString config.services.prowlarr.settings.server.port}
  '';
}
