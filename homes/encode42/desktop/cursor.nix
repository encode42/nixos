{ pkgs, ... }:

{
  home.pointerCursor = {
    gtk.enable = true;

    name = "macchiatoMauve";
    package = pkgs.catppuccin-cursors;
  };
}
