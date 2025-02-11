#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

if ! command -v curl &>/dev/null; then
  apt-get update
  apt-get install -y curl
fi

./sh/mise.sh

if command -v bun &>/dev/null; then
  bun upgrade
else
  export PATH=/opt/bun/bin:$PATH
  if command -v bun &>/dev/null; then
    bun upgrade
  else
    export BUN_INSTALL=/opt/bun
    curl -sSf https://bun.sh/install | bash
  fi
fi

GITURL=$(git config --get remote.origin.url)
GITURL=${GITURL%.git}

git fetch --all && git reset --hard origin/main

if [ -d "secret" ]; then
  cd secret
  git fetch --all && git reset --hard origin/main
  cd ..
else
  git clone --depth=1 $GITURL.secret.git secret
fi

mise trust
bun i
cd sh
bun x cep -c .
mise exec -- bun --bun ./init.js

chmod 700 ~/.ssh
chmod 600 ~/.ssh/*

systemctl restart ssh
