{
  flakeRoot,
  pkgs,
  pkgs-unstable,
  ...
}:

let
  stable-emulators = with pkgs; [
    punes-qt6 # Nintendo Entertainment System
    blastem # Sega Genesis
    bsnes-hd # Nintendo Super Entertainment System
    yabause # Sega Saturn
    duckstation # Sony Playstation 1
    rmg-wayland # Nintendo 64
    flycast # Sega Dreamcast
    mgba # Nintendo Game Boy
    pcsx2 # Sony Playstation 2
    xemu # Microsoft Xbox
    melonDS # Nintendo DS
    ppsspp-qt # Sony Playstation Portable
    rpcs3 # Sony Playstation 3
    azahar # Nintendo 3DS
    cemu # Nintendo Wii U
  ];

  unstable-emulators = with pkgs-unstable; [
    xenia-canary # Microsoft Xbox 360
  ];

  # TODO: Vita3k and Gearsystem
in
{
  imports = [
    (flakeRoot + /homes/encode42/common)

    (flakeRoot + /homes/encode42/common/github.nix)

    (flakeRoot + /homes/encode42/common/bat.nix)
    (flakeRoot + /homes/encode42/common/eza.nix)
    (flakeRoot + /homes/encode42/common/xh.nix)

    (flakeRoot + /homes/encode42/desktop/cursor.nix)
    (flakeRoot + /homes/encode42/desktop/fonts.nix)

    (flakeRoot + /homes/encode42/desktop/environments/gnome.nix)

    (flakeRoot + /homes/encode42/desktop/firefox.nix)

    (flakeRoot + /homes/encode42/desktop/prismlauncher.nix)
  ];

  home.packages = with pkgs; [
    r2modman
    pkgs-unstable.olympus
  ]
  ++ stable-emulators
  ++ unstable-emulators;
}
