# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmon/wmmon-1.0_beta2-r3.ebuild,v 1.4 2005/11/11 09:25:33 s4t4n Exp $

inherit eutils

S="${WORKDIR}/${PN}.app"
IUSE=""
DESCRIPTION="Dockable system resources monitor applet for WindowMaker"
WMMON_VERSION=1_0b2
SRC_URI="http://rpig.dyndns.org/~anstinus/Linux/${PN}-${WMMON_VERSION}.tar.gz"
HOMEPAGE="http://www.bensinclair.com/dockapp/"

DEPEND="virtual/x11
	>=sys-apps/sed-4"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ~amd64 ~ppc"

src_unpack() {
	unpack ${A} ; cd ${S}/${PN}
	epatch ${FILESDIR}/${P}-kernel26-v2.patch
	sed -i -e "s|-O2|${CFLAGS}|" Makefile
}

src_compile() {
	emake -C ${PN} || die
}

src_install () {
	dobin wmmon/wmmon
	dodoc BUGS CHANGES HINTS README TODO
}
