# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/penguin-command/penguin-command-1.6.6.ebuild,v 1.6 2004/05/07 20:52:39 ciaranm Exp $

inherit games

DESCRIPTION="A clone of the classic Missile Command Game"
HOMEPAGE="http://www.linux-games.com/penguin-command/"
SRC_URI="mirror://sourceforge/penguin-command/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc"
IUSE="nls"

DEPEND="media-libs/libpng
	media-libs/jpeg
	>=media-libs/libsdl-1.1.5
	media-libs/sdl-mixer"

src_unpack() {
	unpack ${A}
	sed -i 's:-DUSE_SOUND::' ${S}/configure
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc ChangeLog README NEWS AUTHORS
	[ `use nls` ] || rm ${D}/usr/share/man/man6/*.ja.*
	prepgamesdirs
}
