# Install Golang - ASAP

Install the latest go tools and start working.

Tested with

- Ubuntu 20.04.1 LTS
- Debian 10 (buster) LTS [i386]

## Install

`. ./install.sh` will download the latest `go` tools and set the enviroments vars.
`. ./install-i386.sh` will do the above in 32-bit Linux distros.

### NOTES

#### Change the installation folder

- The install process will set `$GOROOT` and the `$GOPATH` in the `~/.zshrc` AND `~/.bashrc` files; after
  install, if you wanna change the installation folder to other place, remove these lines from theses files:

```bash
# [start] Golang settings, remove after change the installation folder.
export GOROOT=...
export GOPATH=...
# [end]
```

#### Update

Call `. ./install.sh` script again, or `. ./install-i386.sh` if you're on a 32-bit OS.

`Better skills = A better life`
