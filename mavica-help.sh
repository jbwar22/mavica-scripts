#!/usr/bin/env bash

# simply a record of some commands that are useful at each step

cat << EOF
Check Datetime:

Examine image with exiftool. Note the printed create date for the image.
Example: image taken at 13:00, UTC+4
File Modification Date/Time: 09:00:00-04:00    - incorrectly adjusted by timezone, answer "y"
File Modification Date/Time: 13:00:00-04:00    - correct time, answer "n"

To adjust time (if camera clock was incorrect), use:
exiftool -DateTimeOriginal+=2:58:12 FILES...


Fix Portait Files:

to check if immich is logged in, run
immich server-info
EOF
