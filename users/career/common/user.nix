{ pkgs, ... }:

{
  users.users.career = {
    isNormalUser = true;

    shell = pkgs.fish;
  };
}
