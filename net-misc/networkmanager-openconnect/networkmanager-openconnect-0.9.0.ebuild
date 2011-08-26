# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/networkmanager-openconnect/networkmanager-openconnect-0.9.0.ebuild,v 1.1 2011/08/26 20:00:04 nirbheek Exp $

EAPI="4"
GNOME_ORG_MODULE="NetworkManager-${PN##*-}"

inherit gnome.org

DESCRIPTION="NetworkManager OpenConnect plugin"
HOMEPAGE="http://www.gnome.org/projects/NetworkManager/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome"

RDEPEND="
	>=net-misc/networkmanager-${PV}
	>=dev-libs/dbus-glib-0.74
	dev-libs/libxml2:2
	net-misc/openconnect
	gnome? (
		>=x11-libs/gtk+-2.91.4:3
		gnome-base/gconf:2
		gnome-base/gnome-keyring
	)"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/intltool
	dev-util/pkgconfig"

src_configure() {
	ECONF="--disable-more-warnings
		--disable-static
		--with-gtkver=3
		$(use_with gnome)
		$(use_with gnome authdlg)"

	econf ${ECONF}
}

src_install() {
	default
	# Remove useless .la files
	find "${D}" -name '*.la' -exec rm -f {} +
}
