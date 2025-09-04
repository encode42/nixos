{
  config,
  lib,
  flakeRoot,
  pkgs,
  ...
}:

let
  persistentDirectories = [
    ".manpath"
    ".nix-defexpr"
    ".nix-profile"

    ".steam"
    ".local/share/Steam/package"
    ".local/share/Steam/steamapps/common"
  ];

  persistentFiles = [
    ".local/share/Steam/steamapps/libraryfolders.vdf"
  ];

  findDirectoryExclusions = builtins.concatStringsSep " \\\n" (map (path:
    let
      baseExclusion = "-not -path './${config.users.users.guest.home}/${path}";
    in
    "${baseExclusion}' ${baseExclusion}/*'"
  ) persistentDirectories);

  findFileExclusions = builtins.concatStringsSep " \\\n" (map (path:
    "-not -path './${config.users.users.guest.home}/${path}'"
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
          ${findDirectoryExclusions} \
          ${findFileExclusions} \
          -exec echo {} +
      '';
    };
  };
}
