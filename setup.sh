#!/usr/bin/env bash

FILENAME="51-android.rules"

function genRules() {
    echo "# udev rules for android devices (adb/fastboot)" > $FILENAME
    echo "# This file was automatically generated" >> $FILENAME
    echo >> $FILENAME
    local vendors=$(cut -f 1 -d ' ' < vendor-ids.txt)
    for vendor in $vendors
    do
      echo "SUBSYSTEM==\"usb\", ATTR{idVendor}==\"$vendor\", MODE=\"0666\", GROUP=\"plugdev\"" >> $FILENAME
    done
}

# generate rules file
genRules
# copy file to udev folder
sudo cp -f "$(pwd)/$FILENAME" /etc/udev/rules.d/
sudo chmod a+r "/etc/udev/rules.d/$FILENAME"
# restart udev
sudo udevadm control --reload-rules
sudo service udev restart
# restart adb
adb kill-server
adb start-server
