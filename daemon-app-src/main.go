package main

import (
	"log"
	"os"
	"os/signal"
	"syscall"
)

func main() {

	listenChan := make(chan os.Signal)
	signal.Notify(listenChan, []os.Signal{syscall.SIGINT, syscall.SIGTERM, syscall.SIGQUIT}...)

	for {
		_, ok := <-listenChan
		if !ok {
			break
		}

		break
	}

	log.Println("Exit daemon app")
	os.Exit(0)
	return
}
