# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Aubrey Kilian <aubrey@ebe.uct.ac.za>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/trafshow/trafshow-3.1.ebuild,v 1.1 2002/02/16 17:09:51 agriffis Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Full screen visualization of the network traffic"
SRC_URI="ftp://ftp.nsk.su/pub/RinetSoftware/${P}.tgz"
HOMEPAGE="http://soft.risp.ru/trafshow/index_en.shtml"

DEPEND="net-libs/libpcap"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--mandir=\${prefix}/share/man \
		--enable-ipv6 || die "./configure failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"
}
