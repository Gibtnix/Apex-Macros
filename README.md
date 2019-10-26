# GENERAL

Apex-Macros is a minimalistic tool to enable (or disable) the additional macro keys of the
SteelSeries Apex keyboard family. There is no further configuration option available, e.g. color
configurations or polling frequencies cannot be changed. Actually there exist respective Linux
tools, for instance this one: https://github.com/tuxmark5/ApexCtl
My intention to create Apex-Macros just has been the fact that the macro keys are automatically
disabled as soon as you reboot the system, in contrast to the remaining configurations. Hence,
Apex-Macros is more functional and does not aim at all possible, but actually mainly unneeded
configuration options. Consequently there is just a minimum number of additional dependencies.


# INSTALLATION & REQUIREMENTS

I tried to keep the external dependencies to a minimum level, however there are some unavoidable
ones. These are:

 * GCC     - the C compiler
 * make    - the main build tool of the Linux world
 * LIBUSB  - to communicate with the keyboard, LIBUSB is required

To install the program, there is an installation script 'install.sh' which can be run by opening
the respective folder in a terminal and typing

    ./install.sh

or if there are any problems you can try

    bash install.sh

as well which will most certainly will work on most Linux distributions. This script will do the
following steps, if you do not want to use the installation script for some reason, you can use
the manual commands instead:

 * installation of the dependencies
   ```
   sudo apt install -y gcc make libhidapi-dev
   ```

 * compiling of Apex-Macros
   ```
   make
   ```

 * clean up
   ```
   make clean
   ```

 * copy the built program to '/usr/local/bin/apex-macros' and set its permissions
   ```
   sudo mv -fv apex-macros /usr/local/bin/apex-macros
   sudo chmod 755 /usr/local/bin/apex-macros
   ```

Whenever it is used, it should always be run as root because otherwise, the communication with
the keyboard is not possible, hence always use the sudo prefix.


# Supported Devices

Currently the Apex M800, Apex 350 and Apex 300 as well as the respective previous version Apex and
Apex [RAW] are supported (or at least they should be - I could not test them all, so feel free to
give me some feedback if they do or not do).


# USABILITY

First of all: If the program is not executed as root, it will behave as if there currently is no
compatible keyboard connected to the system! Hence if it does not work, make sure you to execute
it as root. The main usability is quite simple, to enable the macro keys just run

    sudo apex-macros enable

or to disable them, run:

    sudo apex-macros disable


# Adding custom actions to the macro keys

The macro keys should be detected by the system if 'sudo apex-macros enable' has been successfully
executed. To verify this it, open a terminal and run (assuming xev is installed on your system
which at least should hold for all ubuntu-based distributions):

    xev

The terminal should notify about key press events as soon as the macro keys are pressed. Further,
some keys are bind to predefined multimedia actions, they should already be usable in your media
player (VLC for instance). There might be some other keys that are mapped to the same key code.
Hence, it is only possible to assign an action to all of them, but not a different action for
each one. This can only be changed by modifying the '90-apex.hwdb' file accordingly.

To map custom commands to the macro keys, please use an additional tool, for instance XBindKeys is
quite popular and optionally also offers a graphical user interface to do so. Apex-Macros' task is
just to enable the respective key press events, but not to define individual actions for them. To
install XBindKeys on a Debian-based system (e.g. any ubuntu-based one), run:

    sudo apt install -y xbindkeys

Additionally you may want to use the graphical user interface, which can be installed by

    sudo apt install -y xbindkeys-config

XBindKeys uses a configuration file .xbindkeysrc, located in your home directory, that can either
be modified using a text editor or using xbindkeys-config; both methods are supporting the Apex
macro keys as soon as they have been activated using 'apex-macros enable'. For further information
about the configuration options of XBindKeys please refer to XBindKeys tutorials or documentations.
However if you have any problems or questions, feel free to use the 'Issue' option.


# AUTOSTART

An useful additional feature is the optional autostart functionality since the macro keys will be
disabled again as soon as restart your computer or put it into standby mode. Hence it is quite
useful to automatically activate the macro keys as soon as a compatible keyboard is connected to
the computer. To do this, there is an additional script called 'autostart.sh' that can do this for
you. This script creates a file

    /etc/udev/rules.d/90-apex-macros.rules

that informs the udev service to call Apex-Macros as soon as a compatible keyboard is connected to
the computer. To create this file simply run:

    ./autostart.sh

Finally the autostart can be disabled by running

    ./autostart.sh --disable

which will disable the autostart by removing the rule file.


# UNINSTALLATION

Apex-Macros also comes with an uninstallation script uninstall.sh which will remove the program
/usr/local/bin/apex-macros as well as running ./autostart --disable, i.e. it disables the
autostart. If you want to use it, simply run:

    ./uninstall.sh
