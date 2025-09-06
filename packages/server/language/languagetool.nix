{ config, pkgs, ... }:

{
  services.languagetool = {
    enable = true;

    # TODO: 1, 2, 3grams and fasttext

    settings = {
      maxTextLength = 380;

      pipelineCaching = true;
      pipelinePrewarming = true;
    };

    jrePackage = pkgs.temurin-jre-bin;
  };
}
