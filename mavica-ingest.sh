#!/usr/bin/env bash

echo mounting floppy...
mountpoint=$(udisksctl mount -b "$MAVICA_SCRIPTS_DEVICE" | awk -F' ' '{print $4}')
dumpdir=$(mktemp -d)
pushd "$mountpoint" &> /dev/null || exit
echo adding metadata...
find . -maxdepth 1 -mindepth 1 \( -iname "*.JPG" -o -iname "*.MPG" \) -exec mavica-set-metadata "{}" "$dumpdir" \;
popd &> /dev/null || exit
pushd "$dumpdir" &> /dev/null || exit
echo "fix portrait files"
echo "ensure immich is logged in"
echo "copy files elsewhere if needed"
echo "^D when done"
bash
echo uploading to immich...
find . -maxdepth 1 -mindepth 1 \( -iname "*.JPG" -o -iname "*.MPG" \) -print0 | xargs -0 immich upload
popd &> /dev/null || exit
pushd "$mountpoint" &> /dev/null || exit
echo "optionally delete files from floppy"
echo "^D when done"
bash
popd &> /dev/null || exit
echo cleaning up...
rm -r "$dumpdir"
umount "/dev/disk/by-id/usb-TEACV0.0_TEACV0.0"
