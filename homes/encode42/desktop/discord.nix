{
  programs.nixcord = {
    enable = true;

    discord.enable = false;

    vesktop = {
      enable = true;

      settings = {
        customTitleBar = true;
        enableSplashScreen = false;

        hardwareVideoAcceleration = true;

        minimizeToTray = false;

        checkUpdates = false;
      };

      useSystemVencord = true;
    };

    config = {
      useQuickCss = false;

      notifyAboutUpdates = false;
      autoUpdate = false;

      themeLinks = [
        "@light https://catppuccin.github.io/discord/dist/catppuccin-latte-mauve.theme.css"
        "@dark https://catppuccin.github.io/discord/dist/catppuccin-macchiato-mauve.theme.css"
      ];

      plugins = {
        webScreenShareFixes.enable = true;
        youtubeAdblock.enable = true;

        fullUserInChatbox.enable = true;
        roleColorEverywhere.enable = true;
        typingTweaks.enable = true;
        alwaysExpandRoles.enable = true;
        betterGifAltText.enable = true;
        betterRoleContext.enable = true;

        viewIcons = {
          enable = true;

          format = "png";
          imgSize = "4096";
        };
      };
    };
  };
}
