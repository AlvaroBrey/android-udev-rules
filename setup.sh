#!/usr/bin/env bash

# do symlink
sudo cp -f "$(pwd)/51-android,rules" /etc/udev/rules.d/
sudo chmod a+r /etc/udev/rules.d/51-android.rules
# restart udev
sudo udevadm control --reload-rules
sudo service udev restart
# restart adb
adb kill-server
adb start-server
