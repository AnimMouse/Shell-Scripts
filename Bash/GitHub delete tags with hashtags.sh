#!/bin/sh
# We need to percent-encode the hashtag or number sign so that the release API can work.
for tag in $(git tag -l "#*"); do gh release delete "%23${tag:1}" -y; done
# But percent-encoding does not work in tags, so we manually delete it using git.
git push -d origin $(git tag -l "#*")