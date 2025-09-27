{ userName, userIcon }:

let
  userFile = ''
    [User]
    Icon=/var/lib/AccountsService/icons/${userName}
  '';
in
{
  systemd.tmpfiles.rules = [
    "d /var/lib/AccountsService/users 0755 root root -"
    "d /var/lib/AccountsService/icons 0755 root root -"
    "f /var/lib/AccountsService/users/${userName} 0644 root root -"
    "f /var/lib/AccountsService/icons/${userName} 0644 root root -"
  ];

  system.activationScripts = builtins.listToAttrs [
    {
      name = "copy-profile-picture-${userName}";

      value.text = ''
        cp ${userIcon} /var/lib/AccountsService/icons/${userName}
        echo "${userFile}" > /var/lib/AccountsService/users/${userName}

        chown root:root /var/lib/AccountsService/{icons,users}/${userName}
        chmod 0644 /var/lib/AccountsService/{icons,users}/${userName}
      '';
    }
  ];
}
