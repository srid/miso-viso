{ pkgs ? import <nixpkgs> {} }:
let
  result = import (pkgs.fetchFromGitHub {
    owner = "dmjio";
    repo = "miso";
    sha256 = "07v2wrinnvkcmrmrav5xngybbms4scqhrhprbfqyak20snr4ir1q";
    rev = "e2a3ac05f6b228c6060046fbdbf3d93c4232229c";
  }) {};
in pkgs.haskell.packages.ghcjs.callPackage ./app.nix {
  miso = result.miso-ghcjs;
}
