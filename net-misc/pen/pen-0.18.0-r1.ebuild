# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/pen/pen-0.18.0-r1.ebuild,v 1.2 2012/02/16 19:10:47 phajdan.jr Exp $

EAPI="4"

DESCRIPTION="TCP Load Balancing Port Forwarder"
HOMEPAGE="http://siag.nu/pen/"
SRC_URI="http://siag.nu/pub/pen/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="ssl"

DEPEND="ssl? ( dev-libs/openssl )"

src_configure() {
	econf $(use_with ssl)
}

src_install() {
	emake DESTDIR="${D}" docdir=/usr/share/doc/${PF} install
}
