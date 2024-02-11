/*
 * file: counter.go
 * author: JT2M0L3Y
 * date: 2024-02-10
 * description: Create file 
 * and write to it every second
 */

package main

import (
	"fmt"
	"os"
	"os/user"
	"time"
)

func main() {
	file, err := os.Create("/tmp/counter.out") 
	counter := 0
	usr, err := user.Current()

	if err != nil {
		fmt.Println("Error creating file:", err)
		return
	}

	// defer closing file until end of function
	defer file.Close()

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

		time.Sleep(1 * time.Second)
		counter++
	}
}