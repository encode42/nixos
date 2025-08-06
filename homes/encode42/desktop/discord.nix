{
  programs.nixcord = {
    enable = true;

    discord.enable = false;

    vesktop = {
      enable = true;

      settings = {
        customTitleBar = true;
        splashTheming = true;

        minimizeToTray = false;

        checkUpdates = false;
      };
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
        chatInputButtonAPI.enable = false;
        commandsAPI.enable = false;
        memberListDecoratorsAPI.enable = false;
        messageDecorationsAPI.enable = false;
        messageEventsAPI.enable = false;
        messagePopoverAPI.enable = false;
        messageUpdaterAPI.enable = false;
        serverListAPI.enable = false;

        webScreenShareFixes.enable = true;
        youtubeAdblock.enable = true;

        settings = {
          settingsLocation = "aboveActivity";
        };

        fullUserInChatbox.enable = true;
        roleColorEverywhere.enable = true;
        typingTweaks.enable = true;
        alwaysExpandRoles.enable = true;
        betterGifAltText.enable = true;
        betterRoleContext.enable = true;

        viewIcons = {
          enable = true;

          format = "png";
          imgSize = 4096;
        };
      };
    };
  };
}
