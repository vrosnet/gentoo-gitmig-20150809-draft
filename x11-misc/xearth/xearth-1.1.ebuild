# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xearth/xearth-1.1.ebuild,v 1.7 2005/11/02 14:58:08 metalgod Exp $

HOMEPAGE="http://www.cs.colorado.edu/~tuna/xearth/"
DESCRIPTION="Xearth sets the X root window to an image of the Earth"
SRC_URI="ftp://cag.lcs.mit.edu/pub/tuna/${P}.tar.gz
	ftp://ftp.cs.colorado.edu/users/tuna/${P}.tar.gz"

SLOT="0"
LICENSE="xearth"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="virtual/x11"

src_compile() {
	xmkmf || die
	mv Makefile Makefile.orig
	sed -e "s:CDEBUGFLAGS = .*:CDEBUGFLAGS = ${CFLAGS} -fno-strength-reduce:" \
			Makefile.orig > Makefile
	emake || die
}

src_install() {
	newman xearth.man xearth.1
	dobin xearth
	dodoc BUILT-IN GAMMA-TEST HISTORY README
}
