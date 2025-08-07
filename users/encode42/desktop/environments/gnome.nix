{ flakeRoot, ... }:

let
  userIcon = flakeRoot + /users/encode42/desktop/42.svg;

  userFile = ''
    [User]
    Icon=/var/lib/AccountsService/icons/encode42
  '';
in
{
  systemd.tmpfiles.rules = [
    "d /var/lib/AccountsService/users 0755 root root -"
    "d /var/lib/AccountsService/icons 0755 root root -"
    "f /var/lib/AccountsService/users/encode42 0644 root root -"
    "f /var/lib/AccountsService/icons/encode42 0644 root root -"
  ];

  system.activationScripts.copy-profile-picture-encode42 = ''
    cp ${userIcon} /var/lib/AccountsService/icons/encode42
    echo "${userFile}" > /var/lib/AccountsService/users/encode42

    chown root:root /var/lib/AccountsService/{icons,users}/encode42
    chmod 0644 /var/lib/AccountsService/{icons,users}/encode42
  '';
}
