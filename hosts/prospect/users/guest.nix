{
  config,
  lib,
  flakeRoot,
  pkgs,
  ...
}:

let
  persistentDirectories = [
    ".nix-profile"
  ];

  findExclusions = builtins.concatStringsSep " \\\n" (map (path:
    let
      baseExclusion = "-not -path '${config.users.users.guest.home}/${path}'";
    in
    "${baseExclusion} ${baseExclusion}/*"
  ) persistentDirectories);
in
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
        find ${config.users.users.guest.home} \
          -mindepth 1 \
          ${findExclusions} \
          -exec echo {} +
      '';
    };
  };
}
