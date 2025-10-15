{ flakeRoot, ... }:

{
  imports = [
    (flakeRoot + /modules/server/nfs.nix)
  ];

  services.nfs.server = {
    nproc = 16;
  };

  # TODO: Write a function that can improve this

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

  fileSystems."/export/torrents" = {
    depends = [
      "/mnt/data"
    ];

    device = "/mnt/data/rtorrent/downloads";
    fsType = "none";

    options = [
      "bind"
      "x-systemd.requires=zfs-mount.service"
    ];
  };

  fileSystems."/export/soulseek" = {
    depends = [
      "/mnt/data"
    ];

    device = "/mnt/data/soulseek/downloads";
    fsType = "none";

    options = [
      "bind"
      "x-systemd.requires=zfs-mount.service"
    ];
  };

  # TODO: Automatically grab user and group IDs?
  services.nfs.server.exports = ''
    /export *(fsid=0,ro,insecure)
    /export/media *(rw,insecure,async,no_subtree_check,nohide,all_squash,anonuid=991,anongid=442)
    /export/torrents *(rw,insecure,async,no_subtree_check,nohide,all_squash,anonuid=987,anongid=972)
    /export/soulseek *(rw,insecure,async,no_subtree_check,nohide,all_squash,anonuid=985,anongid=973)
  '';
}
