{
  stdenv,
  lib,

  makeWrapper,

  coreutils,
  exiftool,
  gawk,
}:

stdenv.mkDerivation rec {
  pname = "mavica-set-metadata";
  version = "1.0.0";
  src = ../.;
  buildInputs = [
    coreutils
    exiftool
    gawk
  ];
  nativeBuildInputs = [ makeWrapper ];
  installPhase = ''
    mkdir -p $out/bin
    cp mavica-set-metadata.sh $out/bin/mavica-set-metadata
    wrapProgram $out/bin/mavica-set-metadata \
      --prefix PATH : ${lib.makeBinPath buildInputs}
  '';
  meta = {
    description = "mavica set metadata: set metadata of mavica images";
    homepage = "https://github.com/jbwar22/mavica-scripts";
  };
}
