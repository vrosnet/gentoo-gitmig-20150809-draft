#!/bin/bash
# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-base/xfree/files/4.2.0-r8/startDM.sh,v 1.1 2002/03/14 23:52:57 azarah Exp $

source /etc/init.d/functions.sh

if [ -e ${svcdir}/options/xdm/service ]
then
	/sbin/start-stop-daemon --start --quiet \
		--exec "`cat ${svcdir}/options/xdm/service`"
	if [ $? -ne 0 ]
	then
		#there was a error running the DM
		einfo "ERROR: could not start the Display Manager..."
	fi
fi

