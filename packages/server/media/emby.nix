{
  hosts ? [ ],
}:

{ flakeLib, emby-flake, ... }:

{
  services.emby = {
    enable = true;

    package = emby-flake.packages.x86_64-linux.default;
  };

  # Caddy reverse proxy configuration
  services.caddy.virtualHosts = flakeLib.mkProxies hosts ''
    reverse_proxy :8096
  '';
}
