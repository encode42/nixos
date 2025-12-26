{
  networking.firewall = {
    enable = true;

    allowPing = false;

    # TODO: look into what's preventing me from using this
    #backend = "nftables";
  };
}
