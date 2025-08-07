{ isLaptop, ... }:

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

        night-light-temperature = "uint32 3700";
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
    };
  };
}
