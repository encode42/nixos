{ config, ... }:

# Socket support: https://github.com/CollaboraOnline/online/issues/7156

{
  imports = [
    ../language/languagetool.nix
  ];

  services.collabora-online = {
    enable = true;

    settings = {
      languagetool = {
        enabled = true;

        base_url = "http://127.0.0.1:${toString config.services.languagetool.port}/v2";

        ssl_verification = false;
      };

      fonts_missing = {
        handling = "report";
      };

      per_document = {
        idlesave_duration_secs = 15;
        autosave_duration_secs = 60;
        always_save_on_exit = true;

        redlining_as_comments = true;

        max_concurrency = 6;
      };

      admin_console = {
        enable = false;
      };

      ssl = {
        enable = false;
      };

      wasm = {
        enable = true;
      };
    };
  };

  boot.kernel.sysctl = {
    "kernel.unprivileged_userns_clone" = 1;
  };
}
