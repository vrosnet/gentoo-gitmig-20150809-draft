# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xosd/xosd-0.7.0.ebuild,v 1.10 2002/12/19 18:06:13 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Library for overlaying text/glyphs in X-Windows \
X-On-Screen-Display plus binary for sending text from command line."
HOMEPAGE="http://www.ignavus.net/"
SRC_URI="http://www.ignavus.net/${P}.tar.gz"
SLOT="0.7"

DEPEND="virtual/x11"
RDEPEND=${DEPEND}
IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/Makefile-gentoo.diff
}
src_compile() {
	make || die
}
src_install () {
	cd ${S}
	insinto /usr/include/xosd-0.7.0
	doins xosd.h
	into /usr
	insinto /usr/lib/xosd-0.7.0
	doins libxosd.a
	doins libxosd.so
	mv osd_cat osd_cat-old
	dobin osd_cat-old
	mv osd_cat.1 osd_cat-old.1
	mv xosd.3 xosd-old.3
	ls -l
	doman osd_cat-old.1
	doman xosd-old.3
	dodoc AUTHORS ChangeLog NEWS COPYING README
}
