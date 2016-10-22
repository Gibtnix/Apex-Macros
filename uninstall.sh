#!/bin/sh

# removes the program by deleting it from /usr/local/bin
if [ -f '/usr/local/bin/apex-macros' ]; then
    sudo rm -v '/usr/local/bin/apex-macros'

    if [ -f './autostart.sh' ]; then
        sudo ./autostart.sh --disable
    fi

    echo "All components of 'apex-macros' were successfully removed!"
else
    echo "Nothing to remove because 'apex-macros' is not installed!"
fi
