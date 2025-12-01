{ pkgs, ... }:

{
  home.packages = with pkgs; [
    slack
    notion-app-enhanced

    # Awaiting the merge of #466573
    #modrinth-app
  ];
}
