{ flakeLib, ... }:

{
  imports = [
    (flakeLib.mkUserIcon {
      userName = "career";
      userIcon = ../modrinth.png;
    })
  ];
}
