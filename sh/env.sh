if [ -z "$CURL" ]; then
  curl -s -o /dev/null -I --connect-timeout 3 -m 4 -s https://x.com || export GFW=1

  if [ -n "$GFW" ]; then
    GITHUB_PROXY=https://ghp.ci/
    git config --global \
      url."${GITHUB_PROXY}https://github.com/".insteadOf \
      "https://github.com/"
    rsync --chown=root:root -av gfw/ /
    sed -i 's/# \(replace-with = '\''rsproxy'\''\)/\1/' ~/.cargo/config.toml
  fi

  export CURL="curl --connect-timeout 5 --max-time 10 --retry 9 --retry-delay 0 -sSf"

  cargo_install() {
    cargo install --locked --root /usr/local $@
  }
  export -f cargo_install

  cargo_install_github() {
    cargo_install --git ${GITHUB_PROXY}https://github.com/$@
  }
  export -f cargo_install_github

  . /etc/profile
fi
