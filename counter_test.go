package main

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestCreateFile(t *testing.T) {
	file := createFile("./bin/test.out")
	assert.NotNil(t, file)

	file.Close()
}

func TestWriteData(t *testing.T) {
	file := createFile("./bin/test2.out")
	assert.NotNil(t, file)

	usr := "smoley"
	dateTime := "2024-02-21 15:04:05"
	counter := 0

	writeData(file, usr, dateTime, counter)

	file.Close()
}

func TestSetSigs(t *testing.T) {
	file := createFile("./bin/test3.out")
	assert.NotNil(t, file)

	setSigs(file)

	file.Close()
}
