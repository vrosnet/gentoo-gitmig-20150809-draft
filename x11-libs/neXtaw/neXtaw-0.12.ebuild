# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/neXtaw/neXtaw-0.12.ebuild,v 1.4 2003/02/13 16:59:59 vapier Exp $

DESCRIPTION="Athena Widgets with N*XTSTEP appearance"
HOMEPAGE="http://siag.nu/neXtaw/"
SRC_URI="http://siag.nu/pub/neXtaw/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 sparc "

RDEPEND="x11-base/xfree"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${P}"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr/X11R6 \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}
