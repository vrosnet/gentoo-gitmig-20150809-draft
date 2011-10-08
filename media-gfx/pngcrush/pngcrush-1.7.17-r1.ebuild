# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pngcrush/pngcrush-1.7.17-r1.ebuild,v 1.2 2011/10/08 19:29:34 ssuominen Exp $

EAPI=4
inherit toolchain-funcs

DESCRIPTION="Portable Network Graphics (PNG) optimizing utility"
HOMEPAGE="http://pmt.sourceforge.net/pngcrush/"
SRC_URI="mirror://sourceforge/pmt/${P}.tar.xz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

# media-libs/libpng
# sys-libs/zlib
RDEPEND=""
DEPEND="${RDEPEND}
	app-arch/xz-utils"

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		LD="$(tc-getCC)" \
		CFLAGS="${CFLAGS} -Wall -Wshadow" \
		LDFLAGS="${LDFLAGS}"
}

src_install() {
	dobin ${PN}
	dohtml ChangeLog.html
}
