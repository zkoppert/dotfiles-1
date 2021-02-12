#!/usr/bin/env zsh

set -o errexit  # exit on fail
set -o pipefail # catch errors in pipelines
set -o nounset  # exit on undeclared variable
# set -o xtrace    # trace execution

# Run a container
docker run -ti --rm "$DOTFILES/lib/docker/ubuntu" env TERM="${TERM}"
