{
  lib,
  pkgs,
  ...
}:

let
  biomePackage = pkgs.biome;
in
{
  programs.zed-editor = {
    enable = true;

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

      buffer_font_family = "Jetbrains Mono";

      terminal = {
        font_family = "Jetbrains Mono";
      };

      languages = {
        Nix = {
          language_servers = [
            "nil"
            "!nixd"
          ];

          formatter.external = {
            command = "nixfmt";
          };
        };
      };

      lsp = {
        nil.settings = {
          nix = {
            # TODO: This is way too much
            maxMemoryMb = 16384;

            flake = {
              autoArchive = true;
              autoEvalInputs = true;
            };
          };
        };

        biome.binary = {
          path = lib.getExe biomePackage;

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
      nixfmt-rfc-style

      biomePackage
      eslint
    ];
  };

  home.packages = with pkgs; [
    jetbrains-mono
  ];
}
