# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/asp2php/asp2php-0.76.17.ebuild,v 1.1 2003/08/02 20:50:46 coredumb Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="ASP to PHP translator"
SRC_URI="http://www.mikekohn.com/asp2php/${P}.tar.gz"
HOMEPAGE="http://asp2php.naken.cc/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	epatch ${FILESDIR}/${P}-makefile.patch
}

src_compile() {
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	
	dobin asp2php
	dodoc LICENSE README
	docinto sample
	dodoc sample/class_test.asp sample/filesystem.asp sample/mailer-test.asp sample/testfile.asp
}

