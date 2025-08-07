{ flakeRoot, ... }:

let
  iconSource = "${flakeRoot}/users/encode42/desktop/42.svg";
in
{
  environment.etc."AccountsService/users/encode42".text = ''
    [User]
    Icon=${iconSource}
  '';

  environment.etc."AccountsService/icons/encode42".source = iconSource;
}
