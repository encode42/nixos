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

  services.omnipoly = {
    port = 6000;
  };
}
