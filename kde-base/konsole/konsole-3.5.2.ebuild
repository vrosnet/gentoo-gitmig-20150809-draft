# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/konsole/konsole-3.5.2.ebuild,v 1.3 2006/04/01 20:12:49 flameeyes Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="X terminal for use with KDE."
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

PATCHES="${FILESDIR}/${PN}-3.5.1-detach-send2all.patch"

RDEPEND="
	|| ( (
			x11-libs/libX11
			x11-libs/libXext
			x11-libs/libXrender
			x11-libs/libXtst
		) virtual/x11 )"

DEPEND="${RDEPEND}
	|| ( x11-apps/bdftopcf virtual/x11 )"

