{ homeDesktop }:

{ lib, ... }:

{
  imports = [
    (homeDesktop + /firefox.nix)
  ];

  programs.firefox = {
    profiles.default = {
      settings = {
        "browser.startup.page" = lib.mkForce 1;
        "browser.startup.homepage" = "https://app.gusto.com|https://app.intercom.com";
      };

      extensions.packages = lib.mkForce [ ];
    };
  };
}
