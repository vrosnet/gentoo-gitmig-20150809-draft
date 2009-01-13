# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/varconf/varconf-0.6.5.ebuild,v 1.4 2009/01/13 20:25:50 ranger Exp $

inherit eutils

DESCRIPTION="A configuration system designed for the STAGE server."
SRC_URI="mirror://sourceforge/worldforge/${P}.tar.bz2"
HOMEPAGE="http://www.worldforge.org/dev/eng/libraries/varconf"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ppc ~x86"
IUSE=""

RDEPEND=">=dev-libs/libsigc++-2.0"
DEPEND="$RDEPEND
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO \
		|| die "Installing doc failed"
}
