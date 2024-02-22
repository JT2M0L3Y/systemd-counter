#!/bin/bash
set -xe

BUILD_ARTIFACTS_DIR="artifacts"
version=`git rev-parse --short HEAD`
VERSION_STRING="$(cat VERSION)-${version}"

# check env vars
[ -z "$BINARY_NAME" ] && echo "BINARY_NAME is not set" && exit 1;
[ -z "$DPKG_NAME" ] && echo "DPKG_NAME is not set" && exit 1;
[ -z "$DPKG_DESC" ] && echo "DPKG_DESC is not set" && exit 1;

if which go; then
  make build BINARY_NAME=${BINARY_NAME}
  echo "Binary built. Building debian package..."
else
  echo "Go is not installed or not reachable. Exiting..."
  exit 1
fi

# create debian package
mkdir -p $BUILD_ARTIFACTS_DIR && cp $BINARY_NAME $BUILD_ARTIFACTS_DIR
if which fpm; then
  fpm --output-type deb \
    --input-type dir --chdir /$BUILD_ARTIFACTS_DIR \
    --prefix /usr/bin --name $BINARY_NAME \
    --version $VERSION_STRING \
    --description `${DPKG_DESC}` \
    -p ${DPKG_NAME}-${VERSION_STRING}.deb \
    $BINARY_NAME && cp *.deb /$BUILD_ARTIFACTS_DIR/
  rm -f $BUILD_ARTIFACTS_DIR/$BINARY_NAME
else
  echo "fpm is not installed or not reachable. Exiting..."
  exit 1
fi
