#!/bin/bash

TEMP_DIR="temp"

echo "Starting deb package build"

# Create the directory structure for the debian package
echo "Creating temporary directory tree"
mkdir -p $TEMP_DIR
mkdir -p $TEMP_DIR/DEBIAN
mkdir -p $TEMP_DIR/usr/bin
mkdir -p $TEMP_DIR/lib/systemd/system

# Create the control file
echo "Creating control file for DEBIAN/"
cp DEBIAN/control $TEMP_DIR/DEBIAN/control
chmod 775 $TEMP_DIR/DEBIAN/control

# Copy the binary into place
echo "Copying binary into place"
cp bin/counter $TEMP_DIR/usr/bin/

# Copy the service file into place
echo "Copying service file into place"
cp counter.service $TEMP_DIR/lib/systemd/system/

# Build the debian package
echo "Building deb file"
dpkg-deb --root-owner-group --build $TEMP_DIR
mv $TEMP_DIR.deb counter-v2.0.0.deb
rm -rf $TEMP_DIR

echo "Complete."
