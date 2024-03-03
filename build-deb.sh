#!/bin/sh

TEMP_DIR=temp

echo "Starting deb package build"

echo "Creating temp directory"
mkdir -p $TEMP_DIR
mkdir -p $TEMP_DIR/DEBIAN
mkdir -p $TEMP_DIR/usr/bin
mkdir -p $TEMP_DIR/lib/systemd/system

cp DEBIAN/control $TEMP_DIR/DEBIAN/control

cp bin/counter $TEMP_DIR/usr/bin/

cp counter.service $TEMP_DIR/lib/systemd/system/

cp DEBIAN/postinst $TEMP_DIR/DEBIAN/
chmod 0775 $TEMP_DIR/DEBIAN/postinst

cp DEBIAN/prerm $TEMP_DIR/DEBIAN/
chmod 0775 $TEMP_DIR/DEBIAN/prerm

cp DEBIAN/postrm $TEMP_DIR/DEBIAN/
chmod 0775 $TEMP_DIR/DEBIAN/postrm

echo "Building deb file"
dpkg-deb --root-owner-group --build $TEMP_DIR
mv $TEMP_DIR.deb counter-v2.0.0.deb

echo "Completed deb build."
