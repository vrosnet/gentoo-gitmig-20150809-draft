# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/e16keyedit/e16keyedit-0.4.ebuild,v 1.2 2006/07/07 13:29:25 vapier Exp $

DESCRIPTION="Key binding editor for enlightenment 16"
HOMEPAGE="http://www.enlightenment.org/"
SRC_URI="mirror://sourceforge/enlightenment/e16utils/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND="=x11-libs/gtk+-2*"

src_compile() {
	econf --enable-gtk2 || die
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc README ChangeLog AUTHORS
}
