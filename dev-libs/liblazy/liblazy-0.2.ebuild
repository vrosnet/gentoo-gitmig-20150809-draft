# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/liblazy/liblazy-0.2.ebuild,v 1.1 2008/06/12 17:25:48 drac Exp $

DESCRIPTION="lib for D-Bus daemon messages, querying HAL or PolicyKit privileges"
HOMEPAGE="http://freedesktop.org/wiki/Software/liblazy"
SRC_URI="http://people.freedesktop.org/~homac/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-apps/dbus"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf --disable-dependency-tracking
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS NEWS README
}
