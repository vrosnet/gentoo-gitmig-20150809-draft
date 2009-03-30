#!/sbin/runscript
# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/qpopper/files/qpopper.init.d,v 1.1 2009/03/30 16:05:45 pva Exp $

depend() {
	need net
}

start() {
	ebegin "Starting qpopper"
	start-stop-daemon --start --quiet --background \
        --exec /usr/sbin/popper -- -f /etc/qpopper.conf
	eend $?
}

stop() {
	ebegin "Stopping qpopper"
	start-stop-daemon --stop --quiet --exec /usr/sbin/popper
	eend $?
}
