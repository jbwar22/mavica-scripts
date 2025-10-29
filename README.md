# Mavica Scripts
Scripts to import photos from funny cameras. Written for the Sony Mavica FD83, but likely to work with other similar cameras

## Requirements
- `exiftool`
- `immich-cli`
- `udisks`
- other basic utils (see buildInputs definitions in nix files in ./package)

## Setup
set environment variables:
- `MAVICA_SCRIPTS_MAKE` - camera make
- `MAVICA_SCRIPTS_MODEL` - camera model
- `MAVICA_SCRIPTS_DEVICE` - floppy drive device in /dev

## Package Binaries
- `mavica-ingest` - automatic ingest script
- `mavica-set-metadata` - set metadata on image or video file (available during ingest)
- `mavica-portrait` - fix portrait image (available during ingest)

## Nix
### Add to your flake
```
mavica-scripts = {
    url = "github:jbwar22/mavica-scripts";
    inputs.nixpkgs.follows = "nixpkgs";
};
```

### Without flakes
see package.nix
