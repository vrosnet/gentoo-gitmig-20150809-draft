# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gok/gok-0.8.3.ebuild,v 1.1 2003/10/10 07:35:21 leonardop Exp $

inherit gnome2 eutils

DESCRIPTION="Gnome Onscreen Keyboard"
HOMEPAGE="http://www.gok.ca/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

RDEPEND=">=x11-libs/gtk+-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libbonobo-2
	>=dev-libs/atk-1.3
	gnome-base/gail
	media-sound/esound
	>=x11-libs/libwnck-1
	>=gnome-extra/at-spi-1.3.4"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	app-text/scrollkeeper"

DOCS="AUTHORS ChangeLog COPYING NEWS README"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gcc2_fix.patch
}

