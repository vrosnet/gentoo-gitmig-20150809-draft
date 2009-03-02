# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/flatzebra/flatzebra-0.1.2.ebuild,v 1.1 2009/03/02 06:57:34 mr_bones_ Exp $

WANT_AUTOCONF=latest
WANT_AUTOMAKE=latest
inherit autotools eutils

DESCRIPTION="A generic game engine for 2D double-buffering animation"
HOMEPAGE="http://perso.b2b2c.ca/sarrazip/dev"
SRC_URI="http://perso.b2b2c.ca/sarrazip/dev/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/libsdl-1.2.4
	>=media-libs/sdl-image-1.2
	media-libs/sdl-mixer"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake \
		DESTDIR="${D}" \
		docdir="/usr/share/doc/${PF}" \
		install || die "emake install failed"
	rm -f "${D}/usr/share/doc/${PF}"/{COPYING,INSTALL}*
	prepalldocs
}
