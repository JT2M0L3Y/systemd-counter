#!/bin/bash

# This script is executed after the package is removed from the system
# It is used mainly to clean up the counter service

echo "Cleaning up counter service"

systemctl daemon-reload

# remove counter user
userdel counter

# remove output file
rm /tmp/currentCount.out