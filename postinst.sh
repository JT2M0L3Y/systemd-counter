#!/bin/bash

# This script is executed after the package is installed on the system
# It is used mainly to start the counter service

echo "Starting counter service"

# Make a 'counter' system user
adduser --system --no-create-home --disabled-login --group counter

# modify the permissions of the counter binary
chown counter:counter /usr/bin/counter

# modify the permissions of the counter service file
chown counter:counter /lib/systemd/system/counter.service

# start counter service as counter user
systemctl daemon-reload
systemctl start counter

# enable counter service to start on boot
systemctl enable counter

# Check the status of the counter service
systemctl status counter

echo "Complete."
