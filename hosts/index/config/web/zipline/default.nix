{ flakeRoot, pkgs, lib, ... }:

let
  title = "deerzip";
  logo = ./deerzip.png;

  host = "deer.zip";

  dataDirectory = "/mnt/data/zipline";

  ziplinePackage = pkgs.zipline.overrideAttrs (old: {
    postInstall = ''
      mkdir -p $out/share/zipline/themes

      cp ${./deerzip_macchiato.theme.json} $out/share/zipline/themes/deerzip_macchiato.theme.json
      cp ${./deerzip_latte.theme.json} $out/share/zipline/themes/deerzip_latte.theme.json
    '';
  });

  ziplineModule = import (flakeRoot + /packages/server/web/zipline.nix) {
    hosts = [
      {
        name = host;
        ssl = "cloudflare";

        extraConfig = ''
          @favicon path /favicon.png

          handle @favicon {
            rewrite * ${logo}
            file_server
          }
        '';
      }
    ];
  };
in
{
  imports = [
    ziplineModule
  ];

  services.zipline = {
    environmentFiles = [ "/mnt/apps/zipline/.env" ];

    settings = {
      WEBSITE_TITLE = title;
      WEBSITE_TITLE_LOGO = "https://${host}/favicon.png";

      WEBSITE_TOS = toString (pkgs.writeText "tos.md" ''
        be gay, don't do crimes
      '');

      WEBSITE_EXTERNAL_LINKS = "[]";

      WEBSITE_THEME_DARK = "deerzip_macchiato";
      WEBSITE_THEME_LIGHT = "deerzip_latte";

      MFA_TOTP_ISSUER = title;

      MFA_PASSKEYS_ENABLED = "true";
      MFA_PASSKEYS_RP_ID = host;
      MFA_PASSKEYS_ORIGIN = "https://${host}";

      CORE_DEFAULT_DOMAIN = host;

      DATASOURCE_LOCAL_DIRECTORY = dataDirectory;
    };

    package = ziplinePackage;
  };

  systemd.services.zipline.serviceConfig = {
    ProtectSystem = lib.mkForce "full";

    ReadWritePaths = [
      dataDirectory
    ];
  };
}
