{ pkgs, ... }:

{
  programs.gnupg.agent = {
    enable = true;

    enableSSHSupport = true;
  };

  environment.shellInit = ''
    gpg-connect-agent /bye
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  '';

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
