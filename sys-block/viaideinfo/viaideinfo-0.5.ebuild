# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/viaideinfo/viaideinfo-0.5.ebuild,v 1.3 2008/04/10 19:21:24 maekke Exp $

DESCRIPTION="Query VIA IDE controllers for various information"
HOMEPAGE="http://www.reactivated.net/software/viaideinfo"
SRC_URI="http://www.reactivated.net/software/viaideinfo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND=">=sys-apps/pciutils-2.2.0"

src_install() {
	emake install DESTDIR="${D}"
	dodoc ChangeLog NEWS README THANKS
}
