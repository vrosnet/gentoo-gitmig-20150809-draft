# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/dmake/dmake-4.12.ebuild,v 1.2 2012/05/13 20:32:07 chithanh Exp $

EAPI=4

inherit eutils

DESCRIPTION="Improved make"
HOMEPAGE="http://tools.openoffice.org/dmake/"
SRC_URI="mirror://debian/pool/main/d/dmake/${P/-/_}.orig.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

# tests fail, bug #404989
RESTRICT="test"

DEPEND="
	app-arch/unzip
	sys-apps/groff
"
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}/${PV}-fix-overlapping-stcpys.patch"
}

src_install () {
	default
	newman man/dmake.tf dmake.1
}
