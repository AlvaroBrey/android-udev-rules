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
echo -n 'Generating rule file... '
genRules
echo 'ok'
# copy file to udev folder
echo -n 'Copying rule file to udev rule directory... '
sudo cp -f "$(pwd)/$FILENAME" /etc/udev/rules.d/
sudo chmod a+r "/etc/udev/rules.d/$FILENAME"
echo 'ok'
# restart udev
echo -n 'Reloading and restarting udev... '
sudo udevadm control --reload-rules
sudo service udev restart
echo 'ok'
# restart adb
echo -n 'Restarting adbd... '
adb kill-server > /dev/null 2>&1
adb start-server > /dev/null 2>&1
echo 'ok'
