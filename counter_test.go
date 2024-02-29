package main

import (
	"os"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestCreateFile(t *testing.T) {
	file := createFile("./bin/test.out")
	assert.NotNil(t, file)

	file.Close()
	os.Remove(file.Name())
}

func TestWriteData(t *testing.T) {
	file := createFile("./bin/test2.out")
	assert.NotNil(t, file)

	usr := "smoley"
	dateTime := "2024-02-21 15:04:05"
	counter := 0

	writeData(file, usr, dateTime, counter)

	file.Close()
	os.Remove(file.Name())
}

func TestSetSigs(t *testing.T) {
	file := createFile("./bin/test3.out")
	assert.NotNil(t, file)

	setSigs(file)

	file.Close()
	os.Remove(file.Name())
}
