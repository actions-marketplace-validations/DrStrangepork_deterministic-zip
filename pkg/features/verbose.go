package features

import (
	"github.com/timo-reymann/deterministic-zip/pkg/cli"
	"github.com/timo-reymann/deterministic-zip/pkg/log"
)

type Verbose struct {
}

func (v Verbose) IsEnabled(c *cli.Configuration) bool {
	return OnFlag(c.Verbose)
}

func (v Verbose) Execute(c *cli.Configuration) error {
	log.SetLevel(log.LevelDebug)
	log.Debug("Enable verbose mode")
	return nil
}