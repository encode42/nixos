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
    ".local/share/Steam/steamapps/common"
    ".local/share/Steam/steamapps/libraryfolders.vdf"
  ];

  rsyncExcludes = builtins.concatStringsSep " \\\n" (map (path: "--exclude='${path}'") persistentPaths);
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
    wantedBy = [ "halt.target" "reboot.target" ];
    before = [ "halt.target" "reboot.target" ];

    serviceConfig = {
      Type = "oneshot";

      ExecStart = pkgs.writeShellScript "clean-guest-home" ''
        rsync -a --delete \
          ${rsyncExcludes} \
          /var/empty ${config.users.users.guest.home}
      '';
    };
  };
}
