{ pkgs, ... }:

{
  users.users.encode42 = {
    isNormalUser = true;

    shell = pkgs.fish;
  };
}
