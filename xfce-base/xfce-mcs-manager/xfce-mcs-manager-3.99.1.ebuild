# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce-mcs-manager/xfce-mcs-manager-3.99.1.ebuild,v 1.1 2003/07/15 03:47:36 bcowan Exp $ 

IUSE=""
S=${WORKDIR}/${P}

DESCRIPTION="Library's for XFCE4"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="http://www.xfce.org/archive/xfce4-rc1/src/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"

DEPEND=">=x11-libs/gtk+-2.0.6
	dev-util/pkgconfig
	dev-libs/libxml2
        =xfce-base/libxfce4util-${PV}
        =xfce-base/libxfcegui4-${PV}
	=xfce-base/libxfce4mcs-${PV}"

src_install() {
        make DESTDIR=${D} install || die

        dodoc AUTHORS INSTALL NEWS COPYING README ChangeLog TODO
}
