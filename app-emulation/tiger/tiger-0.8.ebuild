# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/tiger/tiger-0.8.ebuild,v 1.1 2003/07/16 00:04:31 vapier Exp $

DESCRIPTION="Ti-92 Graphing Calculator Emulator"
SRC_URI="http://xtiger.sourceforge.net/files/${P}.tar.gz"
HOMEPAGE="http://xtiger.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc
	media-libs/libggi"

src_compile() {
	emake || die
}

src_install() {
	dobin tiger || die
	dodoc AUTHORS COPYING ChangeLog HACKING INSTALL README
	doman debian/tiger.1
}
