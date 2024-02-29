## Binary or script directory

#### About
This is a binary compiled from **Go** that performs a number of actions that occur when its systemd service calls it into execution.

#### Features
- creates a file called `currentCount.out` in the `/tmp` directory for logging.
- logs the current `date` and `time` along with the author's `name` and how many `seconds` have passed since the service started
  - format: `author: date time #second`
- scans for a system call to terminate the program, `SIGTERM`, if instigated

#### Updates
For the purposes under which this file was created, this script is to log the author of this repo rather than obtaining the current user as one might get from running the `whoami` command.
