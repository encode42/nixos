{ lib }:

# targets:
# [ { name = str?; path = str; userName = str; groupName = str?; } ];
targets:

{ config, ... }:

let
  extraNfsExports = ''
    /export *(fsid=0,ro,insecure)
  '';

  mkShare =
    target:
    let
      directories = lib.filter (x: x != "") (lib.splitString "/" target.path);

      exportPath = "/export/${target.name or (lib.last directories)}";

      mountName = builtins.elemAt directories 1;
      isZfsPool = lib.elem mountName config.boot.zfs.extraPools;

      user = config.users.users.${target.userName};
      group = config.users.groups.${target.groupName or user.group};

      userId = toString user.uid;
      groupId = toString (group.gid or user.gid);
    in
    {
      inherit exportPath;

      fileSystemMount = {
        device = target.path;
        fsType = "none";

        depends = lib.optionals isZfsPool [ "/mnt/${mountName}" ];
        options = [ "bind" ] ++ lib.optionals isZfsPool [ "x-systemd.requires=zfs-mount.service" ];
      };

      nfsExport = ''
        "${exportPath}" *(rw,insecure,async,no_subtree_check,nohide,all_squash,anonuid=${userId},anongid=${groupId})
      '';
    };

  shares = map mkShare targets;
in
{
  fileSystems = builtins.listToAttrs (
    map (share: {
      name = share.exportPath;
      value = share.fileSystemMount;
    }) shares
  );

  services.nfs.server.exports =
    extraNfsExports + lib.concatStringsSep "\n" (map (share: share.nfsExport) shares);
}
