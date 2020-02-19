#!/bin/sh

if [ -z "$INSTALLPREFIX" ]; then
    INSTALLPREFIX="/usr/local/bin"
fi

# removes the program by deleting it from $INSTALLPREFIX (by default
# from /usr/local/bin)
if [ -f "$INSTALLPREFIX/apex-macros" ]; then
    sudo rm -v "$INSTALLPREFIX/apex-macros"

    if [ -f '/etc/udev/hwdb.d/90-apex.hwdb' ]; then
        sudo rm -v '/etc/udev/hwdb.d/90-apex.hwdb'
        sudo udevadm hwdb --update
        sudo udevadm control --reload
    fi

    if [ -f './autostart.sh' ]; then
        sudo ./autostart.sh --disable
    fi

    echo "All components of 'apex-macros' were successfully removed!"
else
    echo "Nothing to remove because 'apex-macros' is not installed!"
fi
