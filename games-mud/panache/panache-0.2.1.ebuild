# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/panache/panache-0.2.1.ebuild,v 1.4 2004/06/24 23:01:02 agriffis Exp $

DESCRIPTION="Gnome TinyFugue port"
HOMEPAGE="http://panache.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="gnome-base/gconf
	gnome-base/gnome-vfs
	>=x11-libs/gtk+-2
	media-libs/libart_lgpl
	>=gnome-base/libgnomeui-2
	>=gnome-base/libbonoboui-2
	dev-libs/libxml2
	gnome-base/ORBit2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	einstall
}
