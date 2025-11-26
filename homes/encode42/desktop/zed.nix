{ pkgs, pkgs-unstable, ... }:

{
  programs.zed-editor = {
    enable = true;

    package = pkgs-unstable.zed-editor;

    extensions = [
      "rust"

      "nix"
      "toml"
      "json5"
      "env"

      "biome"

      "catppuccin"
      "catppuccin-icons"
    ];

    userSettings = {
      theme = {
        mode = "system";
        light = "Catpuccin Frappé";
        dark = "Catppuccin Macchiato";
      };

      icon_theme = {
        mode = "system";
        light = "Catppuccin Frappé";
        dark = "Catppuccin Macchiato";
      };

      nix = {
        binary = {
          path_lookup = true;

          arguments = [ "autoArchive" ];
        };
      };

      biome = {
        binary = {
          path_lookup = true;

          arguments = [ "lsp-proxy" ];
        };
      };
    };

    extraPackages = with pkgs; [
      rust-analyzer

      bun
      nodejs
      typescript-language-server
      package-version-server

      nil
      nixd

      # stable is way too outdated
      pkgs-unstable.biome
      eslint
    ];
  };
}
