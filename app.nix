{ mkDerivation, base, miso, stdenv }:
mkDerivation {
  pname = "miso-viso";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base miso ];
  description = "Visualization in miso";
  license = stdenv.lib.licenses.unfree;
}
