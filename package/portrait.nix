{
  stdenv,
  lib,

  makeWrapper,

  exiftool,
}:

stdenv.mkDerivation rec {
  pname = "mavica-portrait";
  version = "1.0.0";
  src = ../.;
  buildInputs = [
    exiftool
  ];
  nativeBuildInputs = [ makeWrapper ];
  installPhase = ''
    mkdir -p $out/bin
    cp mavica-portrait.sh $out/bin/mavica-portrait
    wrapProgram $out/bin/mavica-portrait \
      --prefix PATH : ${lib.makeBinPath buildInputs}
  '';
  meta = {
    description = "mavica set portrait: rotate portrait mode photo";
    homepage = "https://github.com/jbwar22/mavica-scripts";
  };
}
