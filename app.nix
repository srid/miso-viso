{ mkDerivation, base, containers, miso, stdenv }:
mkDerivation {
  pname = "miso-viso";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base containers miso ];
  description = "Visualization in miso";
  license = stdenv.lib.licenses.unfree;
}
