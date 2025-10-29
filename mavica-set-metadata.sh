#!/usr/bin/env bash

file=$1
outdir=$2
fixmeta=$3
filenamefull=$(basename -- "$file")
extension="${filenamefull##*.}"
outfile="${outdir}/${filenamefull}"

modifyDate=$(exiftool -FileModifyDate "$file" | awk -F':' '{print $2"-"$3"-"$4":"$5":"$6":"$7}')
# file is stored in utc in local time, then linux adjusts into local timezone
# therefore convert to utc (to get local time) and separately read the timezone
loc=$(date -d "$modifyDate" "+%Y:%m:%d %H:%M:%S%z")
utc=$(date -d "$modifyDate" -u "+%Y:%m:%d %H:%M:%S")
tz=$(date -d "$modifyDate" "+%z")
if [[ "$fixmeta" == "n" ]]; then
    dt="$loc"
else
    dt="$utc$tz"
fi

camera=(-Make="$MAVICA_SCRIPTS_MAKE" -Model="$MAVICA_SCRIPTS_MODEL")
if [[ "$extension" == "MPG" ]]; then
    # write metadata to xmp sidecar
    outfilexmp="${outfile}.xmp"
    exiftool "${camera[@]}" -DateTimeOriginal="$dt" "$outfilexmp"
    cp "$file" "$outdir"
else
    exiftool "${camera[@]}" -SubSecDateTimeOriginal="$dt" "$file" -o "$outfile"
fi
