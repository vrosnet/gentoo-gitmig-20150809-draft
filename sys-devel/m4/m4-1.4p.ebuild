# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/m4/m4-1.4p.ebuild,v 1.11 2002/12/09 04:37:27 manson Exp $

inherit gnuconfig

IUSE="nls"

MY_P=${P/p/ppre2}
S=${WORKDIR}/${MY_P}
DESCRIPTION="GNU macro processor"
SRC_URI="ftp://ftp.seindal.dk/gnu/${MY_P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/m4/m4.html"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc  alpha"

DEPEND="virtual/glibc
	nls? ( sys-devel/gettext )
	>=sys-devel/libtool-1.3.5-r2"

RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	use alpha && gnuconfig_update
}

src_compile() {
	local myconf
	if [ -z "`use nls`" ]
	then
		myconf="--disable-nls"
	fi
	
	./configure --prefix=/usr \
		--libexecdir=/usr/lib \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--with-modules \
		--host=${CHOST} \
		${myconf} || die
		
	make ${MAKEOPTS} || die
}

src_install() {
	make prefix=${D}/usr \
		libexecdir=${D}/usr/lib \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

#	rm -rf ${D}/usr/include

	dodoc AUTHORS BACKLOG ChangeLog COPYING NEWS README* THANKS TODO
	docinto modules
	dodoc modules/README modules/TODO
	docinto html
	dohtml examples/WWW/*.htm
}

