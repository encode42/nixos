{
  nix = {
    channel.enable = false;

    gc = {
      automatic = true;
      dates = "weekly";

      persistent = true;

      options = "--delete-older-than 7d";
    };

    optimise = {
      automatic = true;
      dates = [ "1w" ];

      persistent = true;
    };

    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      download-buffer-size = 512000000;
    };
  };

  documentation.man.enable = false;
}
