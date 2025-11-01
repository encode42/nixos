{ domain, ssl }:

{ pkgs, flakeLib, ... }:

let
  mailDomain = "mx.${domain}";
  tlsDomain = "mta-sts.${domain}";
in
{
  services.caddy.virtualHosts =
    flakeLib.mkProxies
      [
        {
          name = tlsDomain;

          inherit ssl;
        }
      ]
      ''
        file_server

        root * ${
          pkgs.runCommand "testdir" { } ''
            mkdir -p "$out/.well-known"

            printf "%s\n" \
              "version: STSv1" \
              "mode: enforce" \
              "max_age: 604800" \
              "mx: ${mailDomain}" \
              > "$out/.well-known/mta-sts.txt"
          ''
        }
      '';
}
