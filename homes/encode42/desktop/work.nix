{ pkgs, ... }:

{
  programs.fish.functions = {
    server_upload = ''
      set host (string replace :2222 "" $argv[1])
      set username $argv[2]
      set filename $argv[3]

      mscp $filename -o PubkeyAuthentication=no -P 2222 $username@$host:/
    '';
  };

  home.packages = with pkgs; [
    mscp
  ];
}