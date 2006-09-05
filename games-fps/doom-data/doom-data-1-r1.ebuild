# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doom-data/doom-data-1-r1.ebuild,v 1.1 2006/09/05 19:21:23 tupone Exp $

inherit games

DESCRIPTION="collection of doom wad files from id"
HOMEPAGE="http://www.idsoftware.com/"
SRC_URI="mirror://gentoo/doom1.wad.bz2"

LICENSE="freedist"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="doomsday"

DEPEND="doomsday? ( games-fps/doomsday )
	!<=games-fps/freedoom-0.4.1"

S=${WORKDIR}

src_install() {
	insinto "${GAMES_DATADIR}"/doom-data
	doins *.wad || die
	if use doomsday; then
		# Make wrapper for doomsday
		games_make_wrapper doomsday-demo "jdoom -file \
			${GAMES_DATADIR}/doom-data/doom1.wad"
		make_desktop_entry doomsday-demo "Doomsday - Demo"
	fi
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	if use doomsday; then
		einfo "To use the doomsday engine, run doomsday-demo"
	else
		einfo "A Doom engine is required to play the wad"
		einfo "Enable the doomsday use flag if you want to use"
		einfo "	the doomsday engine"
	fi
}
