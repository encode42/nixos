{ flakeRoot, ... }:

{
  nix = {
    channel.enable = false;

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

  programs.nh = {
    enable = true;

    flake = toString flakeRoot;

    clean = {
      enable = true;

      dates = "weekly";

      extraArgs = "--delete-older-than 7d";
    };
  };
}
