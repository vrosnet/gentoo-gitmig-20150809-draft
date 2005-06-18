# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/pfqueue/pfqueue-0.4.1.ebuild,v 1.1 2005/06/18 14:07:53 ticho Exp $

inherit eutils toolchain-funcs

DESCRIPTION="pfqueue is an ncurses console-based tool for managing Postfix
queued messages"
HOMEPAGE="http://pfqueue.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="virtual/libc
		sys-devel/libtool
		sys-libs/ncurses"
RDEPEND="${DEPEND}"

src_compile() {
	econf --libdir=/usr/$(get_libdir)/${PN} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README ChangeLog COPYING NEWS TODO AUTHORS
}
