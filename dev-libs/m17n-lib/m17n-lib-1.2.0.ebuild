# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/m17n-lib/m17n-lib-1.2.0.ebuild,v 1.7 2006/02/10 22:43:01 liquidx Exp $

inherit eutils

DESCRIPTION="Multilingual Library for Unix/Linux"
HOMEPAGE="http://www.m17n.org/m17n-lib/"
SRC_URI="http://www.m17n.org/m17n-lib/download/${P}.tar.gz"

LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="x86 alpha ppc amd64 ppc64 sparc hppa"
IUSE=""

DEPEND="|| ( (
		       x11-libs/libXaw
			   x11-libs/libICE
			   x11-libs/libXrender
			   x11-libs/libXft
			 )
			 virtual/x11
		   )
	dev-libs/libxml2
	dev-libs/fribidi
	>=media-libs/freetype-2.1
	media-libs/fontconfig
	media-libs/gd
	>=dev-libs/libotf-0.9.2
	>=dev-db/m17n-db-${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/m17n-lib-1.1.0-fpic.patch
}

src_compile() {
	econf || die
	emake -j1 || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
