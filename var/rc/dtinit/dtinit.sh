#!/bin/sh

echo;

log() {
	format="[ OK ]"
	echo "$format $1" > /dev/console
}

log "udevd"
lk_runsvc /etc/rc/udevd 0
log "udev-trigger"
lk_runsvc /etc/rc/udev-trigger 0
log "udev-settle"
lk_runsvc /etc/rc/udev-settle 0

log "cgroups"
lk_runsvc /etc/rc/cgroups 0
log "sysctl"
lk_runsvc /etc/rc/sysctl 0
log "dbus"
lk_runsvc /etc/rc/dbus 0
log "connmand"
lk_runsvc /etc/rc/connmand 0
log "elogind"
lk_runsvc /etc/rc/elogind 0

log "ttys"
lk_runsvc /etc/rc/tty1 0
lk_runsvc /etc/rc/tty2 0
lk_runsvc /etc/rc/tty3 0
lk_runsvc /etc/rc/tty4 0
lk_runsvc /etc/rc/tty5 0
lk_runsvc /etc/rc/tty6 0

log "alsa_without_udev_fix"
lk_runsvc /etc/rc/alsa-wo-udev 0

# Uncomment if needed
# lk_runsvc /etc/rc/sddm 0

lk_forever 3600

