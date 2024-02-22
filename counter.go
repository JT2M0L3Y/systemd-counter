/*
 * file: counter.go
 * author: JT2M0L3Y
 * date: 2024-02-21
 * description: Create file 
 * and write to it every second
 */

package main

import (
	"fmt"
	"time"
	"os"
	// "os/user"
	"os/signal"
	"syscall"
)

func main() {
	counter := 0
	// usr, err := user.Current()
	usr := "smoley"

	// create file to write to
	file := createFile("/tmp/currentCount.out")

	// create a channel for signals, track sigint and sigterm
	setSigs(file)

	for {
		// get date and time and format as 2006-01-02 15:04:05
		dateTime := time.Now().Format(time.DateTime)

		// write data to file as: username, date, time, count
		writeData(file, usr, dateTime, counter, false)

		os.Stdout.Sync()
		counter++

		// sleep for 1 second
		time.Sleep(1 * time.Second)
	}
}

func setSigs(file *os.File) {
	sigs := make(chan os.Signal, 1)
	signal.Notify(sigs, syscall.SIGTERM, syscall.SIGINT)

	go func() {
		var sigType string

		// wait for signal type
		switch <-sigs {
		case syscall.SIGTERM:
			sigType = "SIGTERM"
		case syscall.SIGINT:
			sigType = "SIGINT"
		}
		
		// print signal type received
		fmt.Printf(" %s received, exiting...\n", sigType)
		fmt.Fprintf(file, " %s received, exiting...\n", sigType)

		// flush output streams, exit
		os.Stdout.Sync()
		file.Sync()
		file.Close()
		os.Exit(0)
	}()

	return
}

func createFile(name string) *os.File {
	file, err := os.Create(name)
	if err != nil {
		fmt.Println("Error creating file:", err)
		syscall.Exit(1)
	}
	return file
}

func writeData(file *os.File, usr string, dateTime string, counter int, test bool) {
	if test != true {
		fmt.Printf("%s: %s #%d\n", usr, dateTime, counter)
	}
	_, err := file.WriteString(fmt.Sprintf("%s: %s #%d\n", usr, dateTime, counter))
	if err != nil {
		fmt.Println("Error writing to file:", err)
		syscall.Exit(1)
	}
}