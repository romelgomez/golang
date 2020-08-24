# TODO:

- [ ] Re - View https://www.youtube.com/watch?v=YS4e4q9oBaU&t=883s

- [ ] Make TESTs

- [ ] Review  https://gist.github.com/romelgomez/8d515c2d649a4db55ced57195350c268

- [ ] Review https://gist.github.com/romelgomez/0874e88aed0b328f8b4319dc072a2005

- [ ] Review this old notes.

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

- [ ] update readme, check changes in the git history
