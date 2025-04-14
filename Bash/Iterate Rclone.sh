#!/bin/sh
set -eu
while read file; do
rclone copy "$file" . -P
done < list.txt