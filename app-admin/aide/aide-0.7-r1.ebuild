# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/aide/aide-0.7-r1.ebuild,v 1.3 2002/07/11 06:30:09 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="AIDE (Advanced Intrusion Detection Environment) is a free replacement for Tripwire"
SRC_URI="http://www.cs.tut.fi/~rammer/${P}.tar.gz"
HOMEPAGE="http://www.cs.tut.fi/~rammer/aide.html"
LICENSE="GPL-2"

DEPEND="sys-apps/gzip sys-devel/bison sys-devel/flex"

src_compile() {

	# aide 0.7 refuses to compile with postgresql support (missing headerfile?)
	# postgres USE keyword disabled for now... :(

	libtoolize --copy --force
	#if [ -z "`use postgres`" ] ; then
	./configure \
		--prefix=/usr \
		--with-zlib \
		--sysconfdir=/etc/aide \
		host=${CHOST} || die
	make CFLAGS="$CFLAGS" all || die
	#else
	#	try ./configure --prefix=/usr --with-zlib --with-psql
	#	try make CFLAGS=\"$CFLAGS -I/usr/include/postgresql\" all
	#fi

}

src_install() {

	make prefix=${D}/usr mandir=${D}/usr/share/man  install || die

	dodir /etc/aide
	cp doc/aide.conf ${D}/etc/aide

	dodoc AUTHORS COPYING INSTALL NEWS README doc/manual.html

}

