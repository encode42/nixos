{
  pkgs,
  pkgs-personal,
  lib,
  ...
}:

let
  fasttextModel = pkgs.fetchurl {
    url = "https://dl.fbaipublicfiles.com/fasttext/supervised-models/lid.176.bin";
    sha256 = "sha256-fmnsVFG8JhzHhE5J5HkqhdfwnAZ4nsgA/EpErsNidk4=";
  };
in
{
  services.languagetool = {
    enable = true;

    settings = {
      fasttextBinary = lib.getExe pkgs.fasttext;
      inherit fasttextModel;

      maxTextLength = 380;

      pipelineCaching = true;
      pipelinePrewarming = true;

      languageModel = "${pkgs-personal.languagetool-ngrams}/share/languagetool-ngrams";
    };

    jrePackage = pkgs.temurin-jre-bin;
  };

  systemd.services.languagetool.environment = {
    LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib"; # Fix for Hunspell bindings
  };
}
