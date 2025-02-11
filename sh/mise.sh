#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

. env.sh

if command -v mise &>/dev/null; then
  mise self-update && mise upgrade || true
else
  $CURL https://mise.run | MISE_INSTALL_PATH=/usr/local/bin/mise bash
fi

eval $(mise env)
mise settings set experimental true
