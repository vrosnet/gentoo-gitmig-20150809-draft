# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cd-discid/cd-discid-1.3.ebuild,v 1.7 2012/03/31 17:46:21 armin76 Exp $

EAPI=4

inherit toolchain-funcs

DESCRIPTION="returns the disc id for the cd in the cd-rom drive"
HOMEPAGE="https://github.com/taem/cd-discid"
SRC_URI="https://github.com/taem/${PN}/tarball/upstream/${PV} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ppc ppc64 x86"
IUSE=""

DOCS=( changelog README )

src_unpack() {
	unpack ${A}
	mv *-${PN}-* "${S}" || die
}

src_prepare() {
	sed -i -e "/^\(C\|LD\)FLAGS/d" Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)"
}
