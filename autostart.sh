#!/bin/sh

# to enable the autostart, execute this script with
# this script will create a file '/etc/udev/rules.d/99-apex.rules' to enable the keyboard's macro keys at startup or wakeup
# further, this script can also undo this by calling it with the '--disable' argument

# the rules file
file='/etc/udev/rules.d/99-apex.rules'

# the command itself; the wait time can be adjusted if there are some issues with too quick callings
wait=0.5
command="/bin/sh -c 'sleep $wait; /usr/local/bin/apex-macros enable'"

if [ $# -eq 0 ]; then
    # activate the autostart

    # autostart requires 'apex-macros' to be installed
    if [ ! -f '/usr/local/bin/apex-macros' ]; then
        echo "Apex-Macros is not installed, hence no autostart possible"
        exit 1
    fi

    echo "Activating Apex-Macros autostart..."
    sleep 1

    sudo sh -c "echo \"# run Apex-Macros to enable the keyboard's macro keys\" > $file"
    for idP in 1206 1208 1200 1202; do
        echo "ACTION==\"add\", ATTRS{idVendor}==\"1038\", ATTRS{idProduct}==\"$idP\", RUN+=\"$command\"" | sudo tee -a $file > /dev/null
    done

    sudo chmod 755 $file

    echo "Autostart rules file '$file' created"
elif [ $1 = "--disable" ]; then
    # deactivate the autostart

    echo "Deactivating Apex-Macros autostart..."
    sleep 1

    if [ -f $file ]; then
        echo "Removing autostart rules file..."
        sleep 1

        sudo rm -v $file
    fi
else
    echo "Invalid arguments supplied!"
    exit 1
fi
