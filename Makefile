# Author: Jonathan Smoley (JT2M0L3Y)
# Date: 2024-04-24

BINARY_NAME=counter
OUT_FILE=/tmp/currentCount.out
BUILD_SCRIPT=build-deb.sh
GOLANG_VERSION=1.22.2

# install golang
golang-install:
	wget --progress=bar:force:noscroll \
		https://golang.org/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz
	tar -C /usr/local -xzf go${GOLANG_VERSION}.linux-amd64.tar.gz
	rm go${GOLANG_VERSION}.linux-amd64.tar.gz
	go version

# build the binary
build:
	GOARCH=amd64 GOOS=linux go build -o bin/${BINARY_NAME} ${BINARY_NAME}.go

# run the tests
test:
	GOARCH=amd64 GOO=linux go test -v ./...

# run the binary
run: build
	bin/${BINARY_NAME}

# clean up the build files
clean:
	[ -e ${OUT_FILE} ] && rm ${OUT_FILE} || true
	[ -e bin/${BINARY_NAME} ] && rm bin/${BINARY_NAME} || true

## HW 3 Targets

# build the deb package
build-deb: build
	sh ${BUILD_SCRIPT}

# lint the deb package
lint-deb: build-deb
	-lintian ${BINARY_NAME}-v2.0.0.deb

# install the deb package
install-deb: build-deb
	sudo dpkg -i ${BINARY_NAME}-v2.0.0.deb

# remove the deb package
remove-deb:
	sudo dpkg -r ${BINARY_NAME}

## HW 6 Targets

# build the docker image
docker-image:
	docker build -t ${BINARY_NAME}:latest .

# run the docker container in the background
docker-run:
	docker run --rm --mount type=bind,source=/tmp,target=/tmp ${BINARY_NAME}:latest

# remove all those dangling images
docker-prune:
	docker image prune -f