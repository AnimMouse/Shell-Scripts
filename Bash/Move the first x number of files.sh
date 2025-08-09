#!/bin/sh
# Move the first x number of files with support for special characters.
ls -Q $1 | head -100 | xargs -i mv $1/{} $2/