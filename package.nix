{
  stdenv,
  lib,

  makeWrapper,

  bash,
  coreutils,
  exiftool,
  findutils,
  gawk,
  immich-cli,
  udisks,
}:

stdenv.mkDerivation (let
  ingest-inputs = [
    bash
    coreutils
    findutils
    gawk
    immich-cli
    udisks
  ];
  set-metadata-inputs = [
    coreutils
    exiftool
    gawk
  ];
  portrait-inputs = [
    exiftool
  ];
in {
  pname = "mavica-ingest";
  version = "1.1.0";
  src = ./.;
  buildInputs = ingest-inputs ++ set-metadata-inputs ++ portrait-inputs;
  nativeBuildInputs = [ makeWrapper ];
  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/bin/helpers/bin

    cp mavica-set-metadata.sh $out/bin/helpers/bin/mavica-set-metadata
    wrapProgram $out/bin/helpers/bin/mavica-set-metadata \
      --prefix PATH : ${lib.makeBinPath set-metadata-inputs}

    cp mavica-portrait.sh $out/bin/helpers/bin/mavica-portrait
    wrapProgram $out/bin/helpers/bin/mavica-portrait \
      --prefix PATH : ${lib.makeBinPath portrait-inputs}

    cp mavica-ingest.sh $out/bin/mavica-ingest
    wrapProgram $out/bin/mavica-ingest \
      --prefix PATH : ${lib.makeBinPath (ingest-inputs ++ [ "$out/bin/helpers" ])}
  '';
  meta = {
    description = "mavica scripts: set metadata, fix, and ingest ingest images from mavica camera to immich";
    homepage = "https://github.com/jbwar22/mavica-scripts";
  };
})
