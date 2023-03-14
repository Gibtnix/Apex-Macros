#!/bin/sh

# to enable the autostart, simply execute this script with no arguments
# it will create a file '/etc/udev/rules.d/90-apex.rules' to enable the keyboard's macro keys at startup or wakeup
# further, this script can also undo this by calling it with the '--disable' argument

# the rules file
file='/etc/udev/rules.d/90-apex.rules'

if [ $# -eq 0 ]; then
    # activate the autostart

    # autostart requires 'apex-macros' to be installed
    if [ ! -f $(which apex-macros) ]; then
        echo 'Apex-Macros is not installed, hence no autostart possible'
        exit 1
    fi
    if [ ! -f ./90-apex.rules ]; then
        echo 'Rules file not found, did you build the project first with make?'
        exit 1
    fi

    echo 'Activating Apex-Macros autostart...'
    sleep 1
    sudo cp 90-apex.rules $file

    sudo chmod 644 $file

    echo "Autostart rules file '$file' created"
elif [ $1 = '--disable' ]; then
    # deactivate the autostart

    echo 'Deactivating Apex-Macros autostart...'
    sleep 1

    if [ -f $file ]; then
        echo 'Removing autostart rules file...'
        sleep 1

        sudo rm -v $file
    fi
else
    echo 'Invalid arguments supplied!'
    exit 1
fi
