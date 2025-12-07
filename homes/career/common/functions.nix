{ pkgs, lib, ... }:

let
  scpFlags = [
    "-P 2222"
  ];

  scpOptions = [
    "PubkeyAuthentication=no"
    "StrictHostKeyChecking=no"
  ];

  scpDefaults = lib.concatStringsSep " " (scpFlags ++ map (opt: "-o ${opt}") scpOptions);
in
{
  programs.fish.functions = {
    server_upload = ''
      set host (string replace :2222 "" $argv[1])
      set username $argv[2]
      set filename $argv[3]

      mscp $filename ${scpDefaults} $username@$host:/
    '';

    server_download = ''
      set host (string replace :2222 "" $argv[1])
      set username $argv[2]

      set path $argv[3]
      set filename (path basename $path)
      set directory server-$username

      mkdir -p ~/Downloads/$directory

      mscp ${scpDefaults} $username@$host:/$path ~/Downloads/$directory/$filename
    '';
  };

  home.packages = with pkgs; [
    mscp
  ];
}
