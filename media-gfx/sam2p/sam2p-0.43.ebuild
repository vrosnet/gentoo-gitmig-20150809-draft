# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/sam2p/sam2p-0.43.ebuild,v 1.3 2004/06/24 22:49:06 agriffis Exp $

DESCRIPTION="A utility to convert raster images to PDF and others"
HOMEPAGE="http://www.inf.bme.hu/~pts/sam2p/"
SRC_URI="http://www.inf.bme.hu/~pts/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="gif"
DEPEND="virtual/glibc"

src_compile() {
	local myconf="--enable-lzw `use_enable gif`"
	econf ${myconf} || die
	make || die
}

src_install() {
	einstall
	dodoc README
}
