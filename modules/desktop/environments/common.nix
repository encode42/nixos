{ pkgs, ... }:

{
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.xserver = {
    enable = true;

    excludePackages = with pkgs; [
      xterm
    ];
  };
}
