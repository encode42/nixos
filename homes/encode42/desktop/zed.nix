{ pkgs, pkgs-unstable, ... }:

{
  programs.zed-editor = {
    enable = true;

    extensions = [
      "nix"
      "toml"
      "rust"
      "catppuccin"
      "biome"
    ];

    userSettings = {
      theme = {
        mode = "system";
        light = "Catpuccin Frappe";
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
      nil
      nixd

      rust-analyzer

      bun
      nodejs
      eslint

      # stable is way too outdated
      pkgs-unstable.biome

      typescript-language-server
      vscode-langservers-extracted
    ];
  };
}
