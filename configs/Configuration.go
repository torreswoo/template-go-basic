package configs

import (
	"time"
)

var (
	Version   = "undefined"
	BuildTime = "undefined"
	GitHash   = "undefined"
	Started   = time.Now().UTC().Format(time.RFC3339)
)

type Flag struct {
	Version   string
	BuildTime string
	GitHash   string
	Started   string
}

func GetFlag() Flag {
	return Flag{
		Version:   Version,
		BuildTime: BuildTime,
		GitHash:   GitHash,
		Started:   Started,
	}
}
