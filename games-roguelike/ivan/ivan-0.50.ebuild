# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/ivan/ivan-0.50.ebuild,v 1.8 2008/06/17 01:47:44 mr_bones_ Exp $

inherit eutils flag-o-matic games

DESCRIPTION="Rogue-like game with SDL graphics"
HOMEPAGE="http://ivan.sourceforge.net/"
SRC_URI="mirror://sourceforge/ivan/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86 ~x86-fbsd"
IUSE=""

DEPEND="media-libs/libsdl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}"/${P}-gcc41.patch \
		"${FILESDIR}"/${P}-install.patch \
		"${FILESDIR}"/${P}-gcc43.patch
}

src_compile() {
	replace-flags -O? -O0 #bug #113627
	egamesconf || die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog LICENSING NEWS README
	keepdir "${GAMES_STATEDIR}/ivan/Bones"
	prepgamesdirs
	fperms g+w "${GAMES_STATEDIR}/ivan/Bones"
}
