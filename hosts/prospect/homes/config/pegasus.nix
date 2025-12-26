{ flakeRoot, ... }:

let
  emulatorPath = (flakeRoot + /homes/shared/desktop/emulators);

  blastemModule = import (emulatorPath + /blastem.nix) /tmp/test;
in
{
  imports = [
    (flakeRoot + /homes/shared/desktop/pegasus.nix)

    blastemModule
  ];
}
