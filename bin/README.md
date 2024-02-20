## Binary or script directory

#### About
This is a binary written in **Go** to perform a number of actions that occur when an associated systemd service calls it into execution.

#### Features
- finds current user
- creates a file called `currentCount.out` in the `/tmp` directory for logging.
- logs the current `date` and `time` along with the user's `name` and how many `seconds` have passed since the service started
  - format: `user: date time #second`
- scans for a system call to terminate the program, `SIGTERM`, if instigated

#### Updates
For the purposes under which this file was created, this script is to log a hardcoded user rather than obtaining the current user as one might get from running the `whoami` command.
