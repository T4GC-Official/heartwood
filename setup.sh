#!/bin/bash
# setup.sh -- Clone all Good Shepherd ecosystem repos into ./repos/
# Run once after cloning heartwood.
#
# STUB -- repo list to be filled in Part 7 after all repos are confirmed
# and migrated to T4GC-Official.

set -e

WORKSPACE="$(cd "$(dirname "$0")" && pwd)/repos"
mkdir -p "$WORKSPACE"

# Repos will be added here once confirmed.
# git clone git@github.com:$GITHUB_USER/<repo>.git "$WORKSPACE/<repo>"

echo "Done. Repos cloned to $WORKSPACE"
