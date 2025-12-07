{ pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = with pkgs; [
    snapshot
    gnome-connections
    gnome-tour
    yelp
    epiphany
    totem
    gnome-music
    seahorse
  ];

  services.gvfs.enable = true;

  qt = {
    enable = true;

    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  programs.dconf = {
    enable = true;

    profiles.user.databases = [
      {
        settings = {
          "org/gnome/shell" = {
            enabled-extensions = with pkgs; [
              gnomeExtensions.appindicator.extensionUuid
            ];
          };
        };
      }
    ];
  };

  services.udev.packages = with pkgs; [
    gnome-settings-daemon
  ];

  services.dbus.packages = with pkgs; [
    gcr
  ];

  environment.systemPackages = with pkgs; [
    gnomeExtensions.appindicator

    file-roller

    gnome-calendar
    gnome-feeds

    celluloid
    zenity
  ];
}
