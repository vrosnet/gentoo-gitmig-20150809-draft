# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/manpages-cs/manpages-cs-0.16.ebuild,v 1.1 2004/05/15 18:08:45 usata Exp $

DESCRIPTION="A somewhat comprehensive collection of Linux czech man page translations"
SRC_URI="http://homel.vsb.cz/~pop036/files/${P}.tbz2"
#SRC_URI="ftp://ftp.pslib.cz/pub/users/Milan.Kerslager/man-pages-cs/${P}.tar.gz"
# HOMEPAGE is missing

SLOT="0"
LICENSE="freedist"
KEYWORDS="~x86 ~ppc ~alpha"

RDEPEND="sys-apps/man"

src_install() {
	make MANDIR=${D}usr/share/man/cs install || die
	dodoc man-pages-cs* INSTALL README README.Czech
}
