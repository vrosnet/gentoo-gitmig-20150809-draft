# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/newspost/newspost-2.0-r1.ebuild,v 1.1 2005/02/01 16:50:00 swegener Exp $

inherit eutils

DESCRIPTION="a usenet binary autoposter for unix"
HOMEPAGE="http://newspost.unixcab.org/"
SRC_URI="http://newspost.unixcab.org/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

# NOTE: This package should work on PPC but not tested!
# It also has a solaris make file but we don't do solaris.
# but it should mean that it is 64bit clean.
KEYWORDS="x86 ~amd64 ~ppc"

RDEPEND=""
DEPEND=">=sys-apps/sed-4"

src_unpack() {
	unpack $A
	cd $S

	epatch ${FILESDIR}/CAN-2005-0101.patch

	sed -i -e "s:OPT_FLAGS = :OPT_FLAGS = ${CFLAGS}#:" Makefile
}

src_compile() {
	emake || die "emake failed"
}

src_install () {
	dobin newspost || die "dobin failed"
	doman man/man1/newspost.1 || die "doman failed"
	dodoc README CHANGES COPYING || die "dodoc failed"
}
