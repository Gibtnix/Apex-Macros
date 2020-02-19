#!/bin/sh
# this script will create a file '90-apex.rules', which can be installed in
# /etc/udev/rules.d/ to enable the keyboard's macro keys at startup or wakeup

# the command itself; the wait time can be adjusted if there are some issues with too quick callings
wait=0.5
if [ -z "$INSTALLPREFIX" ]; then
    INSTALLPREFIX="/usr/local/bin"
fi
command="/bin/sh -c 'sleep $wait; $INSTALLPREFIX/apex-macros enable'"
file=./90-apex.rules

sh -c "echo \"# run Apex-Macros to enable the keyboard's macro keys\" > $file"
for idP in 1206 1208 1200 1202; do
    echo "ACTION==\"add\", ATTRS{idVendor}==\"1038\", ATTRS{idProduct}==\"$idP\", RUN+=\"$command\"" >> $file
done
