# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/nylon/nylon-1.2-r2.ebuild,v 1.3 2006/03/06 19:32:23 mrness Exp $

DESCRIPTION="A lightweight SOCKS proxy server"
HOMEPAGE="http://monkey.org/~marius/nylon/"
SRC_URI="http://monkey.org/~marius/nylon/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE=""

DEPEND=">=dev-libs/libevent-0.6"

src_install() {
	einstall || die "make install failed"
	dodoc README THANKS

	insinto /etc ; doins "${FILESDIR}/nylon.conf"
	newinitd "${FILESDIR}/nylon.init" nylond
}
