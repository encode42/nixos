{ flakeRoot, ... }:

{
  imports = [
    (flakeRoot + /modules/server/nfs.nix)
  ];

  services.nfs.server = {
    nproc = 16;
  };

  fileSystems."/export/media" = {
    depends = [
      "/mnt/data"
    ];

    device = "/mnt/data/media";
    fsType = "none";

    options = [
      "bind"
      "x-systemd.requires=zfs-mount.service"
    ];
  };

  services.nfs.server.exports = ''
    /export *(fsid=0,ro,insecure)
    /export/media *(rw,insecure,async,no_subtree_check,nohide,all_squash,anonuid=974,anongid=442)
  '';
}
