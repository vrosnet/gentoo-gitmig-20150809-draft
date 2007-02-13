# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/eboard/eboard-1.0.3.ebuild,v 1.2 2007/02/13 19:06:02 nyhm Exp $

inherit eutils games

EXTRAS1="eboard-extras-1pl2"
EXTRAS2="eboard-extras-2"
DESCRIPTION="chess interface for POSIX systems"
HOMEPAGE="http://eboard.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2
	mirror://sourceforge/${PN}/${EXTRAS1}.tar.gz
	mirror://sourceforge/${PN}/${EXTRAS2}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="nls"

RDEPEND=">=x11-libs/gtk+-2
	media-libs/libpng
	dev-lang/perl
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "/DATADIR/ s:\$dataprefix:${GAMES_DATADIR}:" \
		-e "s:(\"-O6\"):split(' ', \"${CXXFLAGS}\"):" configure \
		|| die "sed configure failed"
}

src_compile() {
	egamesconf $(use_enable nls) || die
	emake || die "emake failed"
}

src_install() {
	emake \
		prefix="${D}/${GAMES_PREFIX}" \
		bindir="${D}/${GAMES_BINDIR}" \
		mandir="${D}/usr/share/man" \
		datadir="${D}/${GAMES_DATADIR}/${PN}" \
		install || die "emake install failed"
	dodoc README AUTHORS ChangeLog TODO Documentation/* || die "dodoc failed"

	newicon k18.xpm ${PN}.xpm
	make_desktop_entry ${PN} ${PN} ${PN}.xpm

	cd "${WORKDIR}/${EXTRAS1}"
	insinto "${GAMES_DATADIR}/eboard"
	doins *.png *.wav || die "doins failed (extra1)"
	newins extras1.conf themeconf.extras1 || die "newins failed (extra1)"
	newdoc ChangeLog Changelog.extras || die "newdoc failed (extra1.1)"
	newdoc README README.extras || die "newdoc failed (extra1.2)"
	dodoc CREDITS || die "dodoc failed (extra1)"

	cd "${WORKDIR}/${EXTRAS2}"
	doins *.png *.wav || die "doins failed (extra2)"
	newins extras2.conf themeconf.extras2 || die "newins failed (extra2)"

	prepgamesdirs
}
