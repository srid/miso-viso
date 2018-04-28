{ pkgs ? import (fetchTarball https://github.com/NixOS/nixpkgs/archive/a0aeb2381e5a6c5c57efdec1bf4b4ada44d29511.tar.gz) { } }:
let
  result = import (pkgs.fetchFromGitHub {
    owner = "dmjio";
    repo = "miso";
    rev = "0.20.0.0";
    sha256 = "07gzp84a781h08cbnazqmm03zdb74pg8z5sk9ap1zzswa5nsnygl";
  }) { inherit pkgs; };
in pkgs.haskell.packages.ghcjs.callPackage ./app.nix {
  miso = result.miso-ghcjs;
}
