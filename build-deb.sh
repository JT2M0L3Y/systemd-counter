#!/bin/bash

TEMP_DIR="temp"

echo "Starting deb package build"

echo "Creating temporary directory tree"
mkdir -p $TEMP_DIR
mkdir -p $TEMP_DIR/DEBIAN
mkdir -p $TEMP_DIR/usr/bin
mkdir -p $TEMP_DIR/lib/systemd/system

echo "Creating control file for DEBIAN/"
cp DEBIAN/control $TEMP_DIR/DEBIAN/control
chmod 0775 $TEMP_DIR/DEBIAN/control

echo "Copying binary into place"
cp bin/counter $TEMP_DIR/usr/bin/

echo "Copying service file into place"
cp counter.service $TEMP_DIR/lib/systemd/system/

echo "Building deb file"
dpkg-deb --root-owner-group --build $TEMP_DIR
mv $TEMP_DIR.deb counter-v2.0.0.deb
rm -rf $TEMP_DIR

echo "Complete."
