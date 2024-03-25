# Author: Jonathan Smoley (JT2M0L3Y)
# Date: 2024-03-03

BINARY_NAME=counter
OUT_FILE=/tmp/currentCount.out
BUILD_SCRIPT=build-deb.sh

build:
	go build -o bin/${BINARY_NAME} ${BINARY_NAME}.go

test:
	go test -v ./...

run: build
	bin/${BINARY_NAME}

clean:
	[ -e ${OUT_FILE} ] && rm ${OUT_FILE} || true
	[ -e bin/${BINARY_NAME} ] && rm bin/${BINARY_NAME} || true

build-deb: build
	sh ${BUILD_SCRIPT}

lint-deb: build-deb
	-lintian ${BINARY_NAME}-v2.0.0.deb	
