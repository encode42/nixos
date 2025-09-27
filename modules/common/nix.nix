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
    };
  };

  documentation.man.enable = false;
}
