# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/zoom/zoom-1.0.1.ebuild,v 1.1 2003/09/09 17:34:21 vapier Exp $

DESCRIPTION="A fast, clean, modern Z-code interpreter for X"
HOMEPAGE="http://www.logicalshift.demon.co.uk/unix/zoom/"
SRC_URI="http://www.logicalshift.demon.co.uk/unix/zoom/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE="png"

RDEPEND="virtual/x11
	>=media-libs/t1lib-1.3.1
	png? ( >=media-libs/libpng-1.2.4 )"
DEPEND=">=sys-devel/bison-1.34
	dev-lang/perl"

src_install () {
	into /usr
	dobin src/zoom

	dodoc AUTHORS COPYING ChangeLog NEWS README THANKS TODO
	dohtml -r manual

	insinto /usr/share/zoom
	doins src/zoomrc
}
