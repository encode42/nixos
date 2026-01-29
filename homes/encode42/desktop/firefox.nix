{ firefox-addons, pkgs, ... }:

let
  nixosIcon = "https://wiki.nixos.org/favicon.ico";
in
{
  imports = [
    ../../shared/desktop/firefox.nix
  ];

  programs.firefox = {
    profiles.default = {
      userChrome = ''
        /* hide tab close buttons when tab bar collapsed */
        /* https://www.reddit.com/r/firefox/comments/1klv475/comment/ms5sf93/ */
        #tabbrowser-tabs[orient=vertical]:not([expanded]) .tabbrowser-tab .tab-close-button {
          display: none !important;
        }
      '';

      settings = {
        "sidebar.verticalTabs" = true;
        "sidebar.main.tools" = "history";
        "browser.toolbars.bookmarks.visibility" = "never";

        "browser.newtabpage.enabled" = false;
        "browser.startup.page" = 0;

        "browser.sessionstore.resume_from_crash" = false;

        "browser.download.autohideButton" = false;
        "browser.uiCustomization.horizontalTabstrip" = "[\"tabbrowser-tabs\",\"new-tab-button\"]";
        "browser.uiCustomization.navBarWhenVerticalTabs" =
          "[\"sidebar-button\",\"back-button\",\"forward-button\",\"stop-reload-button\",\"vertical-spacer\",\"urlbar-container\",\"_61a05c39-ad45-4086-946f-32adb0a40a9d_-browser-action\",\"unified-extensions-button\",\"downloads-button\"]";

        "browser.urlbar.suggest.history" = false;
        "browser.urlbar.suggest.recentsearches" = false;

        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.creditCards.enabled" = false;

        "dom.security.https_only_mode" = true;

        "privacy.fingerprintingProtection" = true;
        "privacy.trackingprotection.enabled" = true;
        "browser.safebrowsing.malware.enabled" = false;
        "browser.safebrowsing.phishing.enabled" = false;
      };

      # TODO: configure them too
      extensions = {
        packages = with firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
          fastforwardteam
          indie-wiki-buddy
          linkwarden
        ];

        force = true;
      };

      search = {
        default = "kagi";

        engines = {
          kagi = {
            name = "Kagi";
            definedAliases = [ "@kagi" ];

            iconMapObj."16" = "https://kagi.com/favicon.ico";

            urls = [
              {
                template = "https://kagi.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          minecraft-wiki = {
            name = "Minecraft Wiki";
            definedAliases = [ "@minecraft-wiki" ];

            iconMapObj."16" = "https://minecraft.wiki/favicon.ico";

            urls = [
              {
                template = "https://minecraft.wiki/w/Special:Search";
                params = [
                  {
                    name = "search";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          nixos-wiki = {
            name = "NixOS Wiki";
            definedAliases = [ "@nixos-wiki" ];

            iconMapObj."16" = nixosIcon;

            urls = [
              {
                template = "https://wiki.nixos.org/w/index.php";
                params = [
                  {
                    name = "search";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          nix-packages = {
            name = "Nix Packages";
            definedAliases = [ "@nixpkgs" ];

            iconMapObj."16" = nixosIcon;

            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
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
            definedAliases = [ "@nixos" ];

            iconMapObj."16" = nixosIcon;

            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          home-options = {
            name = "Home Options";
            definedAliases = [
              "@home-options"
              "@home-manager"
            ];

            iconMapObj."16" = "https://home-manager-options.extranix.com/images/favicon.ico";

            urls = [
              {
                template = "https://home-manager-options.extranix.com/";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          wikipedia.definedAliases = [ "@wiki" ];

          amazondotcom-us.metaData.hidden = true;
          bing.metaData.hidden = true;
          ebay.metaData.hidden = true;
          perplexity.metaData.hidden = true;
        };

        order = [
          "kagi"
          "ddg"
          "google"
          "wikipedia"
          "minecraft-wiki"
          "nixos-wiki"
          "nix-packages"
          "nixos-options"
          "home-options"
        ];
      };
    };
  };
}
