{ pkgs, lib, isLaptop, ... }:

{
  dconf = {
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        accent-color = "purple";

        clock-format = "12h";
      };

      "org/gtk/settings/file-chooser" = {
        clock-format = "12h";
      };

      "org/gnome/shell" = {
        favorite-apps = [ ];

        enabled-extensions = with pkgs; [
          gnomeExtensions.appindicator.extensionUuid # TODO: make this not needed
          gnomeExtensions.tiling-shell.extensionUuid
          gnomeExtensions.pano.extensionUuid
          gnomeExtensions.hide-top-bar.extensionUuid
          gnomeExtensions.blur-my-shell.extensionUuid
        ];
      };

      "org/gnome/desktop/search-providers" = {
        disabled = [
          "org.gnome.Characters.desktop"
          "org.gnome.Calculator.desktop"
        ];
      };

      "org/gnome/desktop/sound" = {
        event-sounds = false;
      };

      "org/gnome/desktop/peripherals/mouse" = {
        accel-profile = "flat";
      };

      "org/gnome/settings-daemon/plugins/color" = {
        night-light-enabled = true;
        night-light-schedule-automatic = true;

        night-light-temperature = lib.hm.gvariant.mkUint32 3700;
      };

      "org/gnome/desktop/privacy" = {
        recent-files-max-age = 7;

        remove-old-temp-files = true;
        remove-old-trash-files = true;
      };

      "org/gnome/system/location" = {
        enabled = isLaptop;
      };

      "org/gnome/desktop/datetime" = {
        automatic-timezone = isLaptop;
      };

      "org/gnome/shell/extensions/hidetopbar" = {
        animation-time-autohide = 0.2;
        animation-time-overview = 0.2;

        enable-intellihide = false;

        hot-corner = true;
      };

      "org/gnome/shell/extensions/tilingshell" = {
        top-edge-maximize = true;
      };

      "org/gnome/shell/extensions/pano" = {
        keep-search-entry = false;
        play-audio-on-copy = false;
        send-notification-on-copy = false;

        exclusion-list = ["Goldwarden"];

        session-only-mode = true;
      };

      "org/gnome/shell/extensions/blur-my-shell/hidetopbar" = {
        compatibility = true;
      };

      "org/gnome/shell/extensions/blur-my-shell" = {
        hacks-level = 0;
      };
    };
  };

  home.packages = with pkgs; [
    gnomeExtensions.hide-top-bar
    gnomeExtensions.tiling-shell
    gnomeExtensions.pano
    gnomeExtensions.blur-my-shell
  ];
}
