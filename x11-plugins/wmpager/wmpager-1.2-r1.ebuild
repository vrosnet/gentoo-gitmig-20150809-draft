# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmpager/wmpager-1.2-r1.ebuild,v 1.4 2004/06/28 21:29:00 agriffis Exp $

IUSE=""
DESCRIPTION="A simple pager docklet for the WindowMaker window manager."
HOMEPAGE="http://wmpager.sourceforge.net/"
SRC_URI="mirror://sourceforge/wmpager/${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86"

DEPEND=">=sys-apps/sed-4"

RDEPEND="virtual/x11
	virtual/libc"

src_compile() {
	sed -i "s:\(WMPAGER_DEFAULT_INSTALL_DIR \).*:\1\"/usr/share/wmpager\":" \
		src/wmpager.c

	emake || die
}

src_install() {
	make INSTALLDIR=${D}/usr install || die

	rm -rf ${D}/usr/man
	doman man/man1/*.1x
	dodoc README
}
