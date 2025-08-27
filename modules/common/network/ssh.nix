{ pkgs, ... }:

{
  programs.ssh = {
    package = pkgs.openssh_hpn;
  };
}
