# Golang basic project

## spec
- [Golang](https://golang.org/) - usign [GVM](https://github.com/moovweb/gvm)
- [dep](https://github.com/golang/dep)
- [Makefile](https://wiki.openoffice.org/wiki/MakeFile)

## build & run

- test command
```{bash}
$ GOOS=darwin GOARCH=amd64 go build -o bin/hello -v cmd/hello/main.go
$ ./bin/hello
``` 
- install
```bash
$ make install
```
- check : format, style, lint
```bash
$ make check
```
- build
```bash
$ make build
```
- run
```bash
$ make run
```

## Makefile
- usage go command : go build, go install, dep, gometalinter, ginkgo, rm, gofmt
- make command : all, lint, install, build, build-all, run, run-cont, clean, test, test-cont
- go build options : -ldflags, -i, -o, -v
    - -i : flag installs the packages that are dependencies of the target.
    - -v : print the names of packages as they are compiled.
    - -ldflags : arguments to pass on each go tool link invocation.