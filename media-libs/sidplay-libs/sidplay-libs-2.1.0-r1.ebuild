# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sidplay-libs/sidplay-libs-2.1.0-r1.ebuild,v 1.4 2004/06/24 23:22:44 agriffis Exp $

inherit libtool

DESCRIPTION="C64 SID player library"
HOMEPAGE="http://sidplay2.sourceforge.net/"
SRC_URI="mirror://sourceforge/sidplay2/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	elibtoolize
}

#src_compile() {
#	econf || die
#	emake CFLAGS="${CFLAGS} -L${D}/usr/lib" || die
#}

src_install () {
	make DESTDIR=${D} install || die
}
