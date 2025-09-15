let
  nameservers = [
    "1.1.1.1"
    "1.0.0.1"
  ];
in
{
  services.resolved = {
    enable = true;

    dnssec = "true";
    domains = [ "~." ];

    dnsovertls = "true";

    fallbackDns = nameservers;

    extraConfig = ''
      Cache=no-negative
    '';
  };

  networking = {
    inherit nameservers;

    networkmanager = {
      dns = "systemd-resolved";
    };
  };
}
