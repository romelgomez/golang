# Install Golang - ASAP  

Install the latest go tools and start working.

## Install

`. ./install.sh` will donwload the lasted go tools and set the enviroments vars.

### NOTES

#### Change the installation folder

- The install process will set $GOROOT and the $GOPATH in the `~/.zshrc` AND `~/.bashrc` files, after
install, if you wanna change the installation folder to other place, remove these lines from theses files:

```bash
# [start] Golang settings, remove after change the installation folder.
export GOROOT=...
export PATH=...
export GOPATH=...
# [end]
```

#### Update

Call `. ./install.sh` script again.

## Project structure

### `/go_modules`

`/go_modules` folder is like `/npm_modules`, here we will find

- The go tools
- The vendors modules or vendor pkg

after install some dependencies for example: `go get github.com/pkg/errors`

the files of the pkg error will be in: `go_modules/src/github.com/pkg/errors`

### `/workspace`

`/workspace` folder is where all the work related to your project will live



`Better skills = A better life`
