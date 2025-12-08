{
  config,
  lib,
  pkgs,
  ...
}:

{
  # https://gist.github.com/balacij/492d27776ad7d3cde3e0b0ce0bc3a3f8/11a61171828fa0f76cd403686773c3d455d2c652
  services.udev.extraRules = lib.mkIf config.services.desktopManager.gnome.enable ''
    SUBSYSTEM=="power_supply",ENV{POWER_SUPPLY_ONLINE}=="0",RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set power-saver"
    SUBSYSTEM=="power_supply",ENV{POWER_SUPPLY_ONLINE}=="1",RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set performance"
  '';
}
