{ pkgs, ... }:

{
  systemd.services.libretranslate = {
    description = "LibreTranslate service";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    environment = {
      HOME = "/var/lib/libretranslate";

      LT_DISABLE_FILES_TRANSLATION = "true";
      LT_CHAR_LIMIT = "380";

      LT_THREADS = "8";
    };

    serviceConfig = {
      ExecStart = "${pkgs.libretranslate}/bin/libretranslate";
      DynamicUser = true;
      WorkingDirectory = "/var/lib/libretranslate";
      StateDirectory = "libretranslate";
    };
  };

  environment.systemPackages = with pkgs; [
    libretranslate
  ];
}
