#!/bin/bash
set -eu
while read file; do
ffmpeg -hide_banner -i "$file" -map 0 -c:v libsvtav1 -fps_mode "passthrough" -preset "7" -crf "34" -pix_fmt "yuv420p10le" -svtav1-params "tune=0:keyint=10s" -c:a copy "${file%.*} AV1.mkv" < /dev/tty
done < list.txt