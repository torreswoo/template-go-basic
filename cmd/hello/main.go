package main

import (
	"fmt"
	"github.com/go-kit/kit/log"
	"os"
	"github.com/torreswoo/hello/internal/pkg/config"
)

func main() {
	fmt.Println("Hello world")

	// ENV - get config/ Flag
	flag := config.GetFlag()

	// ENV - setting Logger
	var logger log.Logger
	logger = log.NewLogfmtLogger(log.NewSyncWriter(os.Stdout))
	logger.Log(
		"version", flag.Version,
		"gitHash", flag.GitCommit,
		"buildTime", flag.BuildDate,
		"started", flag.Started,
	)

	logger.Log("message", "START APPLICATION")
}
