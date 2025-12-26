{ pkgs, lib, ... }:

platform: category:

let
  metadataPath = category.storageDirectory + /metadata.txt;

  extensions = lib.concatStringsSep ", " category.extensions;
  arguments = lib.concatStringsSep " " category.launchArgs;

  metadata = ''
    collection: ${category.name}
    shortname: ${platform}
    extensions: ${extensions}
    launch: ${lib.getExe category.package} ${arguments} "{file.path}"
  '';

  metadataFile = pkgs.writeText metadataPath metadata;
in
{
  inherit metadataFile;
}
