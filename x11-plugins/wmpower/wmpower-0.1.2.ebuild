# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmpower/wmpower-0.1.2.ebuild,v 1.2 2003/06/12 22:26:33 seemant Exp $

IUSE=""

DESCRIPTION="WMaker DockApp to get (and set) power management status for laptops. Supports both APM and ACPI kernels. Also has direct support for Toshiba hardware."
HOMEPAGE="http://wmpower.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/x11"

src_compile() {
    emake || die
}

src_install() {
    dodir /usr/bin
    make DESTDIR=${D}/usr install || die
}
