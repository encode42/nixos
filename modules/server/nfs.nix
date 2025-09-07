let
  ports = [
    111
    2049
    4000
    4001
    4002
    20048
  ];
in
{
  imports = [
    ../common/nfs.nix
  ];

  services.rpcbind.enable = true;

  services.nfs.server = {
    enable = true;

    statdPort = 4000;
    lockdPort = 4001;
    mountdPort = 4002;
  };

  networking.firewall = {
    allowedTCPPorts = ports;
    allowedUDPPorts = ports;
  };
}
