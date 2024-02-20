## Systemd Service

#### About
This service runs the `counter.go` binary once added to the `/bin` directory.

#### Features
- requests the `counter` user and group
- executes the `counter.go` binary with the `go` binary using `counter` permissions
- restarts if interrupted after 3 seconds
- waits for multi-user target to request this service