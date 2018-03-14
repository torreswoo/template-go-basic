package main

import (
	"fmt"
	"github.com/torreswoo/hello/configs"
	"github.com/go-kit/kit/log"
	"os"
)
func main(){
	fmt.Println("Hello world");

	// ENV - get config/ Flag
	flag := configs.GetFlag()

	// ENV - setting Logger
	var logger log.Logger
	logger = log.NewLogfmtLogger(log.NewSyncWriter(os.Stdout))
	logger.Log(
		"version", flag.Version,
		"gitHash", flag.GitHash,
		"buildTime", flag.BuildTime,
		"started", flag.Started,
	)

	logger.Log("message", "START APPLICATION")
}
