{
  services.openssh = {
    extraConfig = ''
      Match Address 192.168.1.0/24
        AllowUsers *
    '';
  };
}
