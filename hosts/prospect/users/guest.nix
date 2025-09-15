{
  config,
  lib,
  flakeRoot,
  pkgs,
  ...
}:

let
  persistentPaths = [
    ".manpath"
    ".nix-defexpr"
    ".nix-profile"

    ".local/share/Steam/package"

    ".local/share/Steam/steamapps/libraryfolders.vdf"
    ".local/share/Steam/steamapps/*.acf"
    ".local/share/Steam/steamapps/common"

    ".local/share/PrismLauncher/prismlauncher.cfg" # TODO: Create
    ".local/share/PrismLauncher/instances"

    ".config/mgba/config.ini" # TODO: Create
    ".mgba" # TODO: Move to .config/mgba
  ];

  rsyncExcludes = builtins.concatStringsSep " \\\n" (
    map (path: "--exclude='${path}'") persistentPaths
  );
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
  };

  home-manager.users.guest = {
    imports = [
      ../homes/config/games.nix
      ../homes/guest.nix
    ];

    dconf.settings = {
      "org/gnome/desktop/screensaver" = {
        lock-enabled = false;
        lock-on-suspend = false;
      };
    };

    home.stateVersion = "25.05";
  };

  environment.systemPackages = with pkgs; [
    rsync
  ];

  systemd.services.clean-guest-home = {
    description = "Perform guest account cleanup";
    wantedBy = [ "multi-user.target" ]; # TODO: Only start when the guest account is logged in
    before = [ "shutdown.target" ];

    serviceConfig = {
      Type = "oneshot";

      ExecStart = "${lib.getExe pkgs.bash} -c 'echo Guest account will be reset upon shutdown!'";

      ExecStop = pkgs.writeShellScript "clean-guest-home" ''
        ${lib.getExe pkgs.rsync} -a --delete \
          ${rsyncExcludes} \
          /var/empty/ ${config.users.users.guest.home}/
      '';

      RemainAfterExit = true;
      DefaultDependencies = "no";
    };
  };
}
