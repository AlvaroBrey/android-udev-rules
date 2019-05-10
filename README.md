# android-udev-rules
Udev rule generator and installer for Android devices on Linux systems.

## How to use

1. Clone this this repository and `cd` into it. 
2. Edit `vendor-ids.txt` to add the vendor ID for your device. You can find it using `lsusb`.
3. Run `./setup.sh`. The script will generate a rule file, copy it to the appropriate directory, and restart `udev` and `adb` for you.

> Sometimes restarting `udev` and `adb` is not enough for it to start working.
> You may need to unplug and plug your device, or to restart the computer.
