# note: make sure to create secureboot keys before installation.
# https://github.com/nix-community/lanzaboote/blob/b2f781751764ff57d54f7cf1910ae1bbf268ed1c/docs/QUICK_START.md

{
  lib,
  lanzaboote,
  pkgs,
  ...
}:

{
  imports = [
    lanzaboote.nixosModules.lanzaboote

    ./common.nix
  ];

  boot = {
    loader.systemd-boot.enable = lib.mkForce false;

    lanzaboote = {
      enable = true;

      pkiBundle = "/var/lib/sbctl";
    };
  };

  environment.systemPackages = with pkgs; [
    sbctl
  ];
}
