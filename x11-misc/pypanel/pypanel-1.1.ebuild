# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/pypanel/pypanel-1.1.ebuild,v 1.3 2004/06/01 13:24:18 tseng Exp $

inherit distutils

DESCRIPTION="PyPanel is a lightweight panel/taskbar for X11 window managers."
HOMEPAGE="http://pypanel.sourceforge.net"
SRC_URI="mirror://sourceforge/pypanel/PyPanel-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""
DEPEND=">=x11-base/xfree-4.3.0-r2
	>=dev-lang/python-2.2.3-r1
	>=dev-python/python-xlib-0.12"
S="${WORKDIR}/PyPanel-${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Removing offensive material
	sed -i -e "s/%D %I:%M %p/%Y-%m-%d %H:%M/" pypanelrc
}

src_install() {
	distutils_src_install
	ewarn "If you previously ran 0.8, remove ~/.pypanelrc before starting 1.1!"
}
