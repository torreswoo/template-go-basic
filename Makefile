GOARCH  = amd64
GOOS    = $(OS)

ifeq ($(GOOS),)
  ifeq ($(shell  uname -s), Darwin)
    GOOS	= darwin
  else
    GOOS	= linux
  endif
endif

APP			= hello
MAIN		= cmd/hello/main.go
BIN			= bin/${APP}
VENDOR_DIR	= vendor

# command
GOCMD		= go
GOGET		= $(GOCMD) get -u -v
GOBUILD		= GOOS=$(GOOS) GOARCH=$(GOARCH) $(GOCMD) build
GOINSTALL	= $(GOCMD) install
GODEP		= dep
GOTEST		= ginkgo
GOTEST_OPT	= -r -p -v -cover
RM			= rm -rf

# build flags
VERSION		= "0.0.1"
BUILDTIME	= $(shell TZ=UTC date -u '+%Y-%m-%dT%H:%M:%SZ')

# build commands
.PHONY: all install build build-all test run run-cont clean fclean

all: fclean install lint build-all test

lint:
	$(GOINSTALL) . # https://github.com/alecthomas/gometalinter/issues/9
	gometalinter --vendor --errors

install:
	$(GOGET) github.com/onsi/ginkgo/ginkgo # for test
	$(GOGET) github.com/franciscocpg/gox # for cross compile
	$(GOGET) github.com/githubnemo/CompileDaemon # for reload
	$(GOGET) github.com/alecthomas/gometalinter # for lint
	gometalinter --install --update --force
	$(GODEP) ensure

build: clean
	$(GOBUILD) -i -o ${BIN} -v ${MAIN}

build-all:
	gox -verbose \
	$(LDFLAGS) \
	-os="linux darwin windows freebsd openbsd netbsd" \
	-arch="amd64 386 armv5 armv6 armv7 arm64" \
	-osarch="!darwin/arm64" \
	-output="${BIN}" \
	${MAIN}

test:
	$(GOTEST) $(GOTEST_OPT)

test-cont:
	$(GOTEST) watch $(GOTEST_OPT)

run:
	${BIN}

run-cont: build
	CompileDaemon -exclude-dir="${VENDOR_DIR}" -build="make build" -command="make run" -graceful-kill=true

clean:
	find . -type f -name '*.coverprofile' -exec rm {} +
	$(RM) ${BIN}
	$(RM) vendor/$(IMPORTPATH)

fclean: clean
	$(RM) vendor