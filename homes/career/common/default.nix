{ homeCommon }:

{
  imports = [
    (homeCommon + /fish.nix)

    ./functions.nix

    (homeCommon + /bat.nix)
    ../../shared/common/eza.nix
    ../../shared/common/xh.nix
  ];
}
