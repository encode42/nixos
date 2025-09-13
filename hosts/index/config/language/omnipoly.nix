{ config, flakeRoot, ... }:

let
  omnipolyModule = import (flakeRoot + /packages/server/language/omnipoly.nix) {
    hosts = [
      {
        name = "omnipoly.lan";
        ssl = "internal";
      }
      {
        name = "language.encrypted.group";
        ssl = "cloudflare";
      }
    ];
  };
in
{
  imports = [
    omnipolyModule
  ];

  services.libretranslate = {
    enable = true;

    port = 6400;
  };

  services.languagetool = {
    enable = true;

    port = 6200;
  };

  services.omnipoly = {
    port = 6000;
  };
}
