#!/bin/sh

# Delete remote tags
git push -d origin $(git tag -l "*")

# Delete local tags
git tag -d $(git tag -l "*")