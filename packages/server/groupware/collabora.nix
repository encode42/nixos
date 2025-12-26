{ config, pkgs, pkgs-personal, ... }:

# Socket support: https://github.com/CollaboraOnline/online/issues/7156

{
  imports = [
    ../language/languagetool.nix
  ];

  services.collabora-online = {
    enable = true;

    package = pkgs-personal.collabora-online;

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
        # SSL is not needed as Collabora will always be run locally and/or reverse proxied with SSL.
        # However, SSL is still required by some services (Pydio Cells) in order to connect through secure websockets.
        enable = true;
        termination = true;
        ssl_verification = false;
      };

      wasm = {
        enable = true;
      };
    };
  };

  boot.kernel.sysctl = {
    "kernel.unprivileged_userns_clone" = 1;
  };

  fonts.packages = with pkgs; [
    open-sans
    fira-sans
    ubuntu-sans

    noto-fonts
    roboto

    inter
    ibm-plex
    montserrat
    miracode
    monocraft

    jetbrains-mono
    fira-code
    ubuntu-sans-mono
    roboto-mono
  ];
}
