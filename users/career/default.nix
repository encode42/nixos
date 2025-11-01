# This user is single-purpose, meaning it will only ever be used in one environment.
# As such, a default file has been specified which pulls from any system-side necessary.

{ flakeRoot, ... }:

let
  personalHomeRoot = flakeRoot + /homes/encode42;
  careerHomeRoot = flakeRoot + /homes/career;

  commonModule = import (careerHomeRoot + /common) {
    homeCommon = personalHomeRoot + /common;
  };

  desktopModule = import (careerHomeRoot + /desktop) {
    homeDesktop = personalHomeRoot + /desktop;
  };
in
{
  imports = [
    ./common

    ./desktop/environments/gnome.nix

    ./desktop/winboat.nix
  ];

  home-manager.users.career = {
    imports = [
      commonModule
      desktopModule
    ];

    home.stateVersion = "24.05";
  };
}
