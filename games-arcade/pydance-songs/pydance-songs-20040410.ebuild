# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/pydance-songs/pydance-songs-20040410.ebuild,v 1.2 2004/04/11 08:44:13 dholm Exp $

inherit games

DESCRIPTION="Music for the pyDDR game"
HOMEPAGE="http://icculus.org/pyddr/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="X11"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

RDEPEND="games-arcade/pydance"

S="${WORKDIR}"

src_install() {
	insinto "${GAMES_DATADIR}/pydance/songs"
	cd "${S}"
	doins * || die
}
