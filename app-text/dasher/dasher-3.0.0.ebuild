# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/dasher/dasher-3.0.0.ebuild,v 1.4 2003/07/12 22:26:34 aliz Exp $

DESCRIPTION="information-efficient text-entry interface, \
	driven by natural continuous pointing gestures"
HOMEPAGE="http://www.inference.phy.cam.ac.uk/dasher/"
SRC_URI="http://www.inference.phy.cam.ac.uk/dasher/download/linux/source/3.0/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"

DEPEND="=dev-cpp/gtkmm-1.2*"

KEYWORDS="x86 ~ppc ~sparc ~alpha"

src_unpack() {
		unpack ${A}
}

src_compile() {
        econf || die "bad ./configure"
        make || die "compile problem"
}

src_install() {
        make install DESTDIR=${D} || die
}
											
