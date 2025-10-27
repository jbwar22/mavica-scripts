#!/usr/bin/env bash

file=$1
exiftool -Orientation=8 -n "$file" -overwrite_original
