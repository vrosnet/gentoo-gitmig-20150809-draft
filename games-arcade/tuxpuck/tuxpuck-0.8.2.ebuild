# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/tuxpuck/tuxpuck-0.8.2.ebuild,v 1.8 2007/04/09 21:26:23 welp Exp $

inherit games

DESCRIPTION="Hover hockey"
HOMEPAGE="http://www.efd.lth.se/~d00jkr/tuxpuck/"
SRC_URI="http://www.efd.lth.se/~d00jkr/tuxpuck/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=media-libs/libsdl-1.1.5
	media-libs/libpng
	>=media-libs/libvorbis-1.0_rc3"

src_unpack() {
	unpack ${A}
	cd "${S}"
	gunzip man/tuxpuck.6.gz || die
}

src_compile() {
	# Note that the Makefiles for tuxpuck are buggy so -j1 is used.
	emake -j1 CPP_FLAGS="${CPPFLAGS} -I/usr/include/libpng12" || die
}

src_install() {
	dogamesbin tuxpuck || die "dogamesbin failed"
	doman man/tuxpuck.6
	dodoc *.txt
	prepgamesdirs
}
