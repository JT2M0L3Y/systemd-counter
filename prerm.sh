#!/bin/bash

# This script is executed before the package is removed from the system
# It is used mainly to stop the counter service

echo "Stopping counter service"

# set counter service to not start on boot
systemctl disable counter

# stop counter service
systemctl stop counter
