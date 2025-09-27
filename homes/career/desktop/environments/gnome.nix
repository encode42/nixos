{ homeDesktop }:

{ pkgs, lib, ... }:

{
  imports = [
    (homeDesktop + /environments/gnome.nix)
  ];

  dconf = {
    settings = {
      "org/gnome/desktop/interface" = {
        accent-color = lib.mkForce "green";
      };
    };
  };

  xdg.autostart = {
    enable = true;

    entries = [
      "${pkgs.firefox}/share/applications/firefox.desktop"
      "${pkgs.slack}/share/applications/slack.desktop"
    ];
  };
}
