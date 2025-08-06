{ pkgs, ... }:

{
  programs.fish = {
    enable = true;

    plugins = with pkgs.fishPlugins; [
      {
        name = "bobthefish";
        src = bobthefish.src;
      }
    ];

    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
  };
}
