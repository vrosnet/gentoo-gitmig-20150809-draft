# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/yamcha/yamcha-0.33.ebuild,v 1.1 2006/06/19 23:12:19 usata Exp $

DESCRIPTION="Yet Another Multipurpose CHunk Annotator"
HOMEPAGE="http://chasen.org/~taku/software/yamcha/"
SRC_URI="http://chasen.org/~taku/software/yamcha/src/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
#IUSE="perl python ruby"

DEPEND="sci-misc/tinysvm
	dev-lang/perl"
#RDEPEND=""

src_test() {
	make check || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS README
}
