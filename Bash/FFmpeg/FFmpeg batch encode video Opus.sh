#!/bin/bash
set -eu
for file in $1/*.mkv; do
  ffmpeg -hide_banner -i "$file" -map 0 -c:v copy -c:a libopus -b:a 64k "${file%.*} Opus.mkv" < /dev/tty
  touch -d "$(date -Rr "$file")" "${file%.*} Opus.mkv"
done