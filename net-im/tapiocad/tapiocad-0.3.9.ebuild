# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/tapiocad/tapiocad-0.3.9.ebuild,v 1.2 2006/10/08 18:04:22 blubb Exp $

DESCRIPTION="Tapioca framework for VOIP and IM"
HOMEPAGE="http://tapioca-voip.sf.net"
LICENSE="LGPL-2"
SRC_URI="mirror://sourceforge/tapioca-voip/tapioca-${PV}.tar.gz"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
S="${WORKDIR}/tapioca-${PV}"
RDEPEND=">=dev-libs/glib-2
	sys-apps/dbus"

src_install() {
	make DESTDIR=${D} install || die "make install failed"
}
