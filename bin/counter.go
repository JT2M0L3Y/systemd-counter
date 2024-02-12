/*
 * file: counter.go
 * author: JT2M0L3Y
 * date: 2024-02-12
 * description: Create file 
 * and write to it every second
 */

package main

import (
	"fmt"
	"time"
	"os"
	"os/user"
	"os/signal"
	"syscall"
)

func main() {
	counter := 0
	usr, err := user.Current()

	// create a channel for signals, track sigint and sigterm
	sigs := make(chan os.Signal, 1)
	// signal.Notify(sigs, syscall.SIGINT, syscall.SIGTERM)
	signal.Notify(sigs, syscall.SIGTERM)

	// create file to write to
	file, err := os.Create("/tmp/currentCount.out") 

	if err != nil {
		fmt.Println("Error creating file:", err)
		return
	}

	// defer closing file until end
	defer file.Close()

	go func() {
		var sigType string

		// wait for signal type
		switch <-sigs {
		// case syscall.SIGINT:
		// 	sigType = "SIGINT"
		case syscall.SIGTERM:
			sigType = "SIGTERM"
		}
		
		// print signal type received
		fmt.Printf(" %s received, exiting...\n", sigType)
		fmt.Fprintf(file, " %s received, exiting...\n", sigType)

		// flush output streams, exit
		os.Stdout.Sync()
		file.Sync()
		os.Exit(0)
	}()

	for {
		// get date and time and format as 2006-01-02 15:04:05
		dateTime := time.Now().Format(time.DateTime)

		// write data to file as: username, date, time, count
		_, err = fmt.Fprintf(file, "%s: %s #%d\n", usr.Username, dateTime, counter)

		// write data to console the same as file
		fmt.Printf("%s: %s #%d\n", usr.Username, dateTime, counter)

		if err != nil {
			fmt.Println("Error writing to file:", err)
			return
		}

		os.Stdout.Sync()
		counter++

		// sleep for 1 second
		time.Sleep(1 * time.Second)
	}
}