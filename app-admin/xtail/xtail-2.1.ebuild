# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/xtail/xtail-2.1.ebuild,v 1.2 2002/07/11 06:30:09 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Tail multiple logfiles at once, even if rotated."
SRC_URI="http://www.unicom.com/sw/xtail/${P}.tar.gz"
HOMEPAGE="http://www.unicom.com/sw/xtail/"

DEPEND="virtual/glibc"

src_compile() {
	./configure --prefix=/usr \
		--host=${CHOST} \
		--mandir=/usr/share/man || die
	emake || die
}

src_install () {
	into /usr
	doman xtail.1
	dobin xtail
	dodoc README
}
