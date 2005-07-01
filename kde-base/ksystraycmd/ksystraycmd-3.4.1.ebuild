# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksystraycmd/ksystraycmd-3.4.1.ebuild,v 1.4 2005/07/01 11:25:40 corsair Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: Allows any application to be kept in the system tray"
KEYWORDS="amd64 ~ppc ppc64 ~sparc x86"
IUSE=""


