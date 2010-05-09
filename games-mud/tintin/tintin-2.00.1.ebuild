# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/tintin/tintin-2.00.1.ebuild,v 1.2 2010/05/09 18:42:24 armin76 Exp $

inherit games

DESCRIPTION="(T)he k(I)cki(N) (T)ickin d(I)kumud clie(N)t"
HOMEPAGE="http://tintin.sourceforge.net/"
SRC_URI="mirror://sourceforge/tintin/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="sys-libs/zlib
	dev-libs/libpcre
	sys-libs/readline
	sys-libs/ncurses"

S=${WORKDIR}/tt/src

src_install () {
	dogamesbin tt++ || die "dogamesbin failed"
	dodoc ../{CREDITS,FAQ,README,SCRIPTS,TODO,docs/*}
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	ewarn "**** OLD TINTIN SCRIPTS ARE NOT 100% COMPATIBLE WITH THIS VERSION ****"
	ewarn "read the README for more details."
	echo
}
