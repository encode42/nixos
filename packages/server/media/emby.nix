{ emby-flake, ... }:

{
  services.emby = {
    enable = true;

    package = emby-flake.packages.x86_64-linux.default;
  };
}
