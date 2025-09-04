{
  lib,
  flakeRoot,
  pkgs,
  ...
}:

{
  imports = [
    ../config/games.nix
  ];

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "guest";

  users.users.guest = {
    isNormalUser = true;

    description = "Guest";

    password = "";
  };

  home-manager.users.guest = {
    imports = [
      ../homes/config/games.nix
      ../homes/guest.nix
    ];

    home.stateVersion = "25.05";
  };

  systemd.services.clean-guest-home = {
    description = "Perform guest account cleanup";
    wantedBy = [ "halt.target" "reboot.target" ];
    before = [ "halt.target" "reboot.target" ];

    serviceConfig = {
      Type = "oneshot";

      ExecStart = pkgs.writeShellScript "clean-guest-home" ''
        find ${home-manager.users.guest.homeDirectory} \
          -mindepth 1 \
          -not -path "$HOME/.nix-profile" \
          -not -path "$HOME/.nix-profile/*" \
          -not -path "$HOME/.config" \
          -not -path "$HOME/.config/*" \
          -not -path "$HOME/.local" \
          -not -path "$HOME/.local/*" \
          -exec echo {} +
      '';
    };
  };
}
