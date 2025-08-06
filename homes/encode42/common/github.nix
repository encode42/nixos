{ pkgs, ... }:

{
  imports = [
    ./git.nix
  ];

  programs.gh = {
    enable = true;

    gitCredentialHelper = {
      enable = true;
    };
  };

  home.packages = with pkgs; [
    gh
  ];
}
