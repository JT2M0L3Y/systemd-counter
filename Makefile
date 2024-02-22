BINARY_NAME=counter
OUT_FILE=/tmp/currentCount.out
BUILD_SCRIPT=build-dev.sh

build:
	GOARCH=amd64 GOOS=linux go build -o bin/${BINARY_NAME} ${BINARY_NAME}.go

test:
	GOARCH=amd64 GOO=linux go test -v ./...

run: build
	bin/${BINARY_NAME}

clean:
	[ -e bin/${BINARY_NAME} ] && rm bin/${BINARY_NAME} || true
	[ -e ${OUT_FILE} ] && rm ${OUT_FILE} || true
	[ -e bin/test.out ] && rm bin/test.out || true
	[ -e bin/test2.out ] && rm bin/test2.out || true
	[ -e bin/test3.out ] && rm bin/test3.out || true

build-deb:

lint-deb:
