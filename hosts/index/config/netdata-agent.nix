{ flakeRoot, ... }:

{
  imports = [
    (flakeRoot + /packages/server/netdata-agent.nix)
  ];

  services.netdata = {
    claimTokenFile = "/mnt/apps/netdata/.claim-token";
  };
}
