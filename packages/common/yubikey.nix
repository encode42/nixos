{ pkgs, ... }:

{
  programs.gnupg.agent = {
    enable = true;

    enableSSHSupport = true;
  };

  services.pcscd = {
    enable = true;
  };

  security.pam.services = {
    login.u2fAuth = true;
  };

  services.udev.packages = with pkgs; [
    yubikey-personalization
  ];

  environment.systemPackages = with pkgs; [
    yubikey-manager
  ];
}
