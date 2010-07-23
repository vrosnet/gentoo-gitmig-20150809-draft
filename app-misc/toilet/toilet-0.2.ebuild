# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/toilet/toilet-0.2.ebuild,v 1.2 2010/07/23 11:52:22 maekke Exp $

EAPI=2

DESCRIPTION="The Other Implementations letters. Figlet replacement."
HOMEPAGE="http://libcaca.zoy.org/toilet.html"
SRC_URI="http://caca.zoy.org/raw-attachment/wiki/${PN}/${P}.tar.gz"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/libcaca-0.99_beta17"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	sed -i \
		-e 's:-g -O2 -fno-strength-reduce -fomit-frame-pointer::' \
		configure || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog NEWS README TODO
}
