# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/zangband/zangband-2.7.4.ebuild,v 1.1 2003/11/25 10:57:52 mr_bones_ Exp $

inherit games

DESCRIPTION="An enhanced version of the Roguelike game Angband"
HOMEPAGE="http://www.zangband.org/"
SRC_URI="ftp://clockwork.dementia.org/angband/Variant/ZAngband/${P}.tar.gz"

KEYWORDS="x86 ppc"
LICENSE="Moria GPL-2"
SLOT="0"
IUSE="X"

DEPEND=">=sys-libs/ncurses-5
	sys-libs/zlib
	>=sys-apps/sed-4
	tcltk? ( dev-lang/tcl dev-lang/tk )
	gtk? ( =x11-libs/gtk+-1* )
	X? ( virtual/x11 )"

S="${WORKDIR}/${PN}"

src_compile() {
	egamesconf \
		--datadir="${GAMES_DATADIR_BASE}" \
		"--with-setgid=${GAMES_GROUP}" \
		`use_with gtk` \
		`use_with tcltk` \
		`use_with X x` || die
	emake || die "emake failed"
}

src_install() {
	# Keep some important dirs we want to chmod later
	keepdir ${GAMES_DATADIR}/zangband/lib/apex
	keepdir ${GAMES_DATADIR}/zangband/lib/user
	keepdir ${GAMES_DATADIR}/zangband/lib/save

	# Install the basic files but remove unneeded crap
	make DESTDIR=${D}/${GAMES_DATADIR}/zangband/ installbase || \
		die "make installbase failed"
	rm ${D}${GAMES_DATADIR}/zangband/{angdos.cfg,readme,z_faq.txt,z_update.txt}

	# Install everything else and fix the permissions
	dogamesbin zangband                 || die "dogamesbin failed"
	dodoc readme z_faq.txt z_update.txt || die "dodoc failed"
	find "${D}${GAMES_DATADIR}/zangband/lib" -type f -exec chmod a-x \{\} \;

	prepgamesdirs
	# All users in the games group need write permissions to some important dirs
	chmod -R g+w ${D}/${GAMES_DATADIR}/zangband/lib/{apex,save,user}
}
