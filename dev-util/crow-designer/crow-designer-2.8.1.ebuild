# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/crow-designer/crow-designer-2.8.1.ebuild,v 1.1 2006/10/26 17:56:14 pva Exp $

DESCRIPTION="GTK+ GUI building tool"
HOMEPAGE="http://gideon.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/crow-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.8.0
		>=dev-libs/guiloader-2.0.8
		>=dev-libs/guiloader-c++-2.0.8
		>=gnome-base/gnome-vfs-2"

S="${WORKDIR}"/crow-${PV}

src_compile() {
	econf || die "configuration failed"
	emake || die "compilation failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README NEWS
}
