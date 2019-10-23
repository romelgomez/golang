# Install Go Tools

1) Download a binary release suitable for your system in [https://golang.org/dl/](https://golang.org/dl/)

2) Open an terminal, stay in $HOME
3) `git clone https://github.com/romelgomez/go.git`
4) `source go/install_go_tools.sh -b go_binary.tar.gz`
  
    Example:

    `source go/install_go_tools.sh -b $HOME/Downloads/go1.12.4.linux-amd64.tar.gz`

5) Is done, the go tools are installed now.

    NOTE:  To update-change the version, change the value of `-b` property which it is passed to the installer, `go_binary.tar.gz` and run again.


## known errors

Buils serverless golang project with `make` command

Error:

```bash
dep ensure -v
make: dep: Command not found
Makefile:4: recipe for target 'build' failed
make: *** [build] Error 127
```

Solution:

`sudo apt-get install go-dep`

dep is a dependency management tool for Go. It requires Go 1.9 or newer to compile

Ref:

- [https://github.com/golang/dep](https://github.com/golang/dep)
- [https://serverless.com/blog/framework-example-golang-lambda-support/](https://serverless.com/blog/framework-example-golang-lambda-support/)

---

> Better skills = A better life
