# Systemd Service Debian Package for Golang Counter

## About
This is a simple systemd service that runs a seconds logger in the background.
It is written in Golang and is packaged as a debian package.

## Build
To build the package, run the following command:
- `make build-deb`

## Installation
To install the package, run the following commands:
- `sudo dpkg -i counter-v2.0.0.deb`

This will install the debian package and send both the service to `/lib/systemd/system` and its associated go binary to `/bin`. 
This command also triggers a post-install script that will create a user for the service and start it.

## Usage
The service will start automatically after installation. 
To check the status of the service, run `sudo service counter status`.
Start, stop, and restart the service using the `start`, `stop`, and `restart` commands.
Check the file in which seconds are being logged with `cat /tmp/currentCount.out`.
> Note, the service will automatically restart if it is stopped.

## Uninstallation
To uninstall the package, run the following command:
- `sudo dpkg -r counter`

This will remove the debian package, the service, and the user created for the service.
Running this command triggers a pre-remove script to stop the serice and a post-remove script to remove the user and the output file.
