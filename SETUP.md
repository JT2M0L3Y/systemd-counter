## Installation and Running

> Note: a number of these commands may need sudo privilege

#### File Setup
- make any desired changes to the service or the go script
- copy files to their respective places within the file system
  - `cp ./counter.go /bin`
  - `cp ./counter.service /lib/systemd/system`

#### Permission Modifications
- create a new user: `adduser counter --system`
- create a new group: `groupadd counter`
- add your new user to the group: `usermod -a -g counter counter`
- run `whoami` command for current user
- add current user to group: `usermod -a -g counter <result of whoami command>`
- modify owner of script and service: `chown counter counter.*`
- modify group of script and serivce: `chgrp counter counter.*`

#### Execution
- execute `systemctl daemon-reload` to update the system with the service
- execute `service counter start` to start the service
- execute `service counter status` if service info is ever needed
- execute `service counter stop` if needing to stop the service