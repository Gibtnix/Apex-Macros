#!/bin/sh

# script to automatically do the following steps:
#   - install the dependencies to compile the program, i.e. install 'gcc', 'make' and 'libhidapi-dev'
#     remark: once the program is compiled, 'libhidapi-dev' isn't required any more, only 'libhidapi-libusb0' is
#   - compile the program
#   - move the program 'apex-macros' to '/usr/local/bin/apex-macros'
#   - run 'apex-macros' with the 'enable' option to check if everything works

echo 'Installation script for Apex-Macros'
echo '###################################'
sleep 1

echo 'Installing dependencies...'
sleep 2

if (sudo apt install -y gcc make libhidapi-dev); then
    echo 'Dependencies successfully installed'
    sleep 2
else
    echo 'Dependencies could not be installed'
    exit 1
fi

echo 'Compiling Apex-Macros...'
sleep 2

# compile
if (make); then
    make clean
    echo 'Compiling finished successfully'
    sleep 2
else
    echo 'Compiling failed'
    exit 1
fi

# install 'apex-macros' to '/usr/local/bin/apex-macros' which also makes it callable via the apex-macros command
if (sudo make install); then
    make delete
    echo 'Installation of Apex-Macros finished successfully'
    sleep 2
else
    echo 'Installation of Apex-Macros failed'
    exit 1
fi;

echo 'Testing Apex-Macros...'
sleep 1

if (sudo apex-macros enable); then
    # configure macro keys
    sudo cp '90-apex.hwdb' '/etc/udev/hwdb.d/90-apex.hwdb'
    sudo udevadm hwdb --update
    sudo udevadm control --reload

    echo 'The macro keys were successfully enabled.'
    echo "To manually enable / disable the macro keys, run 'apex-macros enable' or 'apex-macros disable', respectively."
    echo "If you want to enable the autostart, run 'autostart.sh', to uninstall 'apex-macros' run 'uninstall.sh'."
    echo 'Thank you for using Apex-Macros and have fun with it! :-)'
else
    echo 'Testing of Apex-Macros failed'
fi
