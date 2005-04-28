# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmlaptop/wmlaptop-1.3.ebuild,v 1.3 2005/04/28 20:36:41 wormo Exp $

IUSE=""

MY_P=${P}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Dockapp for laptop users"
SRC_URI="http://www.dockapps.org/download.php/id/474/${P}.tar.bz2"
HOMEPAGE="http://www.dockapps.org/file.php/id/227"

DEPEND="virtual/x11"
RDEPEND=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

src_compile() {
	cd ${S}
	emake CFLAGS="${CFLAGS} -Wall" || die "Compilation failed"
}

src_install() {
	dodir /usr/bin
	einstall INSTALLDIR="${D}/usr/bin" || die "Installation failed"

	dodoc AUTHORS README README.IT THANKS

	insinto /usr/share/applications
	doins ${FILESDIR}/${PN}.desktop
}
