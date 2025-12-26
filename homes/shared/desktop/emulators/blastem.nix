storageDirectory:

{ pkgs, flakeLib, ... }:

# Lock-on cartridges use -o
# No argument to specify settings path

flakeLib.mkPegasus "genesis" {
  inherit storageDirectory;

  name = "Sega Genesis";

  extensions = [
    "zip" # zlib
    "md"
    "bin"
  ];

  package = pkgs.blastem;
  launchArgs = [
    "-f"
    "-m gen"
  ];
}
