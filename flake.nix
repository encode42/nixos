{
  description = "Personal-use NixOS configuration";

  inputs = {
    # Basic Nix/OS functionality
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    disko = {
      url = "github:nix-community/disko/v1.12.0";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.3-1.tar.gz";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Desktop modules
    niri = {
      url = "github:sodiboo/niri-flake";
    };

    # Declarative addon systems
    nix-jetbrains-plugins = {
      url = "github:theCapypara/nix-jetbrains-plugins";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = {
      url = "github:kaylorben/nixcord";

      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Server modules
    vpn-confinement.url = "github:Maroka-chan/VPN-Confinement";

    emby-flake = {
      url = "github:tofu-salad/emby-server-flake";
    };

    # Community-maintained package repositories
    encode42-packages = {
      url = "github:encode42/nixos-packages";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-winboat.url = "github:Rexcrazy804/nixpkgs/winboat-init";
  };

  outputs = args: import ./outputs.nix args;
}
