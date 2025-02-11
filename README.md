```
export GIT_SSH_COMMAND='ssh -i ~/.ssh/id_ed25519.i18n'

cd /tmp
rm -rf os
git clone --depth=1 git@github.com:i18n-ops/os.git
mv os/.* /os/
mv os/* /os/
cd /os && ./init.sh
```
