# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gnet/gnet-1.1.9.ebuild,v 1.8 2004/02/17 21:58:07 agriffis Exp $

DESCRIPTION="GNet network library."
SRC_URI="http://www.gnetlibrary.org/src/${P}.tar.gz"
HOMEPAGE="http://www.gnetlibrary.org/"

IUSE=""
SLOT="1"
LICENSE="LGPL-2"
KEYWORDS="x86 ~ppc hppa amd64 alpha ia64"

# yes, the >= is correct, this software can use both glib 1.2 and 2.0!
RDEPEND=">=dev-libs/glib-1.2.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf \
		--with-html-dir=${D}/usr/share/doc/${PF} \
		--sysconfdir=/etc \
		--localstatedir=/var/lib || die

	emake || die
}

src_install() {
	make \
		prefix=${D}/usr \
		datadir=${D}/usr/share \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		sysconfdir=${D}/etc \
		localstatedir=${D}/var/lib \
		install || die

	dodoc AUTHORS BUGS ChangeLog COPYING NEWS README TODO
}
