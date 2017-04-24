#!/usr/bin/env bash

# do symlink
sudo ln -sf "$(pwd)/51-android,rules" /etc/udev/rules.d/
# restart udev
sudo udevadm control --reload-rules
sudo service udev restart
# restart adb
adb kill-server
adb start-server
