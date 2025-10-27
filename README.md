# Mavica Scripts
Scripts to import photos from funny cameras. Written for the Sony Mavica FD83, but likely to work with other similar cameras

## Requirements
- exiftool
- immich-cli
- udisks
- other basic utils (see buildInputs definitions in nix files in ./package)

## Setup
set environment variables:
- MAVICA_SCRIPTS_MAKE - camera make
- MAVICA_SCRIPTS_MAKE - camera model
- MAVICA_SCRIPTS_DEVICE - floppy drive device in /dev
