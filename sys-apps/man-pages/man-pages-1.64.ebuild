# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/man-pages/man-pages-1.64.ebuild,v 1.6 2004/02/23 00:45:53 agriffis Exp $

DESCRIPTION="A somewhat comprehensive collection of Linux man pages"
SRC_URI="mirror://kernel/linux/docs/manpages/${P}.tar.bz2"
RESTRICT="nomirror"
HOMEPAGE="http://www.win.tue.nl/~aeb/linux/man/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc sparc alpha mips hppa ia64 ppc64"

RDEPEND="sys-apps/man"

src_install() {
	einstall MANDIR=${D}/usr/share/man || die
	dodoc man-pages-*.Announce README
}
