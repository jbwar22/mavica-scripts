{
  stdenv,
  lib,

  makeWrapper,

  bash,
  coreutils,
  findutils,
  gawk,
  immich-cli,
  udisks,

  mavica-set-metadata,
  mavica-portrait
}:

stdenv.mkDerivation rec {
  pname = "mavica-ingest";
  version = "1.0.0";
  src = ../.;
  buildInputs = [
    bash
    coreutils
    findutils
    gawk
    immich-cli
    udisks

    mavica-set-metadata
    mavica-portrait
  ];
  nativeBuildInputs = [ makeWrapper ];
  installPhase = ''
    mkdir -p $out/bin
    cp mavica-ingest.sh $out/bin/mavica-ingest
    wrapProgram $out/bin/mavica-ingest \
      --prefix PATH : ${lib.makeBinPath buildInputs}
  '';
  meta = {
    description = "mavica ingest: ingest images from mavica to immich";
    homepage = "https://github.com/jbwar22/mavica-scripts";
  };
}
