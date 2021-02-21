# Install Golang - ASAP

Install the latest go tools and start working.

Tested with

- Ubuntu 20.04.1 LTS

## Install

`. ./install.sh` will donwload the lasted go tools and set the enviroments vars.

### NOTES

#### Change the installation folder

- The install process will set $GOROOT and the $GOPATH in the `~/.zshrc` AND `~/.bashrc` files, after
  install, if you wanna change the installation folder to other place, remove these lines from theses files:

```bash
# [start] Golang settings, remove after change the installation folder.
export GOROOT=...
export GOPATH=...
# [end]
```

#### Update

Call `. ./install.sh` script again.

`Better skills = A better life`
