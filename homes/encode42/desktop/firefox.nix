{ firefox-addons, pkgs, ... }:

{
  programs.firefox = {
    enable = true;

    policies = {
      BlockAboutConfig = true;
    };

    profiles.default = {
      settings = {
        "extensions.autoDisableScopes" = 0;

        "sidebar.verticalTabs" = true;
        "sidebar.main.tools" = "history";
        "browser.toolbars.bookmarks.visibility" = "never";

        "browser.newtabpage.enabled" = false;
        "browser.startup.page" = 0;

        "browser.download.autohideButton" = false;
        "browser.uiCustomization.horizontalTabstrip" = "[\"tabbrowser-tabs\",\"new-tab-button\"]";
        "browser.uiCustomization.navBarWhenVerticalTabs" =
          "[\"sidebar-button\",\"back-button\",\"forward-button\",\"stop-reload-button\",\"vertical-spacer\",\"urlbar-container\",\"_61a05c39-ad45-4086-946f-32adb0a40a9d_-browser-action\",\"unified-extensions-button\",\"downloads-button\"]";

        "browser.urlbar.suggest.history" = false;
        "browser.urlbar.suggest.recentsearches" = false;

        "privacy.history.custom" = true;
        "browser.formfill.enable" = false;
        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.creditCards.enabled" = false;

        "dom.security.https_only_mode" = true;

        "privacy.fingerprintingProtection" = true;
        "privacy.trackingprotection.enabled" = true;
        "browser.safebrowsing.malware.enabled" = false;
        "browser.safebrowsing.phishing.enabled" = false;

        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.usage.uploadEnabled" = false;
      };

      extensions = {
        packages = with firefox-addons.packages.${pkgs.system}; [
          fastforwardteam
          indie-wiki-buddy
        ];
      };

      search = {
        force = true;

        default = "searx";

        engines = {
          searx = {
            name = "encrypted group search";
            definedAliases = [ "@searx" ];

            urls = [
              {
                template = "https://search.encrypted.group/search?q={searchTerms}";
              }
            ];
          };

          nix-packages = {
            name = "Nix Packages";
            iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
            definedAliases = [ "@nixpkgs" ];

            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          nixos-options = {
            name = "NixOS Options";
            iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
            definedAliases = [ "@nixos" ];

            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "type";
                    value = "options";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          nixos-wiki = {
            name = "NixOS Wiki";
            iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
            definedAliases = [ "@nixos-wiki" ];

            urls = [
              {
                template = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
              }
            ];
          };

          bing.metaData.hidden = true;
        };

        order = [
          "ddg"
          "google"
          "nix-packages"
          "nixos-options"
          "nixos-wiki"
        ];
      };
    };
  };
}
