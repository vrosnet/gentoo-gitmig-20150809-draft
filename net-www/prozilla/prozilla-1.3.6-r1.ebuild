# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
#$Header: /var/cvsroot/gentoo-x86/net-www/prozilla/prozilla-1.3.6-r1.ebuild,v 1.1 2002/02/09 21:06:32 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A download manager"
SRC_URI="http://prozilla.delrom.ro/packages/prozilla/tarballs/${P}.tar.gz"
HOMEPAGE="http://prozilla.delrom.ro/"

DEPEND="virtual/glibc >=sys-libs/ncurses-5.2"

src_compile() {
    ./configure --prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--host=${CHOST} \
		--sysconfdir=/etc || die
	emake || die
}

src_install () {
	make DESTDIR=${D} \
	sysconfdir=${D}/etc \
	install || die
	dodoc ANNOUNCE AUTHORS COPYING CREDITS ChangeLog FAQ NEWS README TODO
}

