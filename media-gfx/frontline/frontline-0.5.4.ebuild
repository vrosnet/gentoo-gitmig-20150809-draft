# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/frontline/frontline-0.5.4.ebuild,v 1.5 2004/07/05 13:14:23 pauldv Exp $

IUSE=""

DESCRIPTION="Front-End to Autotrace (Converts Bitmaps to vector-grahics)"
SRC_URI="http://ftp1.sourceforge.net/autotrace/${P}.tar.gz"
HOMEPAGE="http://autotrace.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=media-gfx/autotrace-0.31.1
	=media-gfx/gimp-1.2*
	!<media-gfx/gimp-1.2.1
	>=media-libs/libart_lgpl-2.3.8
	>=media-libs/imlib-1.8.2
	gnome-base/gnome-libs"

src_compile() {
	econf || die "econf failed"
	emake -j 1 || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README
}
