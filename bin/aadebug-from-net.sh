#!/bin/sh

source script-x


#!/bin/bash

echo "ALSA Audio Debug v0.1.0 - $(date)"
echo "http://alsa.opensrc.org/aadebug"
echo "http://www.gnu.org/licenses/gpl.txt"
echo
echo Kernel ----------------------------------------------------
uname -a
echo
echo Loaded Modules --------------------------------------------
lsmod | grep ^snd
lsmod | egrep -q '(^usb-midi|^audio)'
if [ $? -eq 0 ]; then
    echo "Warning: either 'audio' or 'usb-midi' OSS modules are loaded"
    echo "this may interfere with ALSA's snd-usb-audio."
    if [ ! -f /etc/hotplug/blacklist ]; then
        echo "You should create a file '/etc/hotplug/blacklist' with"
    echo "both names on it to avoid hotplug loading them."
    else
    egrep -q '(^usb-midi|^audio)' /etc/hotplug/blacklist
    if [ $? -eq 1 ]; then
        echo "You should add both modules to '/etc/hotplug/blacklist'"
        echo "to avoid hotplug loading them."
    fi
    fi
fi
echo
if [ "$(echo $(uname -r) | grep 2.6)" -a -f /proc/config.gz ]; then
echo Proc Config -----------------------------------------------
zcat /proc/config.gz | egrep "(CONFIG_SOUND|CONFIG_SND)"
echo
fi
echo Modprobe Conf ---------------------------------------------
if [ -f /etc/modprobe.conf ] ; then
    egrep '(sound|snd)' /etc/modprobe.conf
elif [ -f /etc/modules.conf ] ; then
    egrep '(sound|snd)' /etc/modules.conf
else
    echo "Warning: module config file does not exist"
    echo "This means any kernel modules will not be auto loaded"
    echo "See your linux distro docs on how to create this file"
fi
echo
echo Proc Asound -----------------------------------------------
if [ ! -d /proc/asound ] ; then
    echo "Warning: /proc/asound does not exist"
    echo "This indicates that ALSA is not installed correctly"
    echo "Check various logs in /var/log for a clue as to why"
else
    cat /proc/asound/{version,cards,devices,hwdep,pcm,seq/clients}
fi
echo
echo Dev Snd ---------------------------------------------------
if [ ! -d /dev/snd ] ; then
    echo "Warning: /dev/snd does not exist"
else
    /bin/ls -C /dev/snd
fi
echo
echo CPU -------------------------------------------------------
grep -e "model name" -e "cpu MHz" /proc/cpuinfo
echo
echo RAM -------------------------------------------------------
grep -e MemTotal -e SwapTotal /proc/meminfo
echo
echo Hardware --------------------------------------------------
# Note: this command may not be in a non-root users path
lspci | egrep "(Multimedia|Host bridge)"
echo
