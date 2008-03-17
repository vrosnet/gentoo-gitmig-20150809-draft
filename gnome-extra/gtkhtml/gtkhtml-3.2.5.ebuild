# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gtkhtml/gtkhtml-3.2.5.ebuild,v 1.11 2008/03/17 02:13:58 leio Exp $
EAPI="1"

inherit gnome2 eutils

DESCRIPTION="Lightweight HTML Rendering/Printing/Editing Engine"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2"
SLOT="3.2"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="net-libs/libsoup:2.2
	>=x11-libs/gtk+-2.2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libgnomeprint-2.2
	>=gnome-base/libgnomeprintui-2.2.1
	>=x11-themes/gnome-icon-theme-1.2
	>=gnome-base/libglade-2
	>=gnome-base/libbonoboui-2.2.4
	>=gnome-base/gail-1
	!=gnome-extra/gtkhtml-3.1.19
	!=gnome-extra/gtkhtml-3.1.20"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.30
	>=dev-util/pkgconfig-0.12.0"

USE_DESTDIR="1"
SCROLLKEEPER_UPDATE="0"
ELTCONF="--reverse-deps"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# bug 101970
	epatch "${FILESDIR}/${PN}-3.0.10-no-extern-cluealigned.diff"
	epatch "${FILESDIR}/${PN}-3.2-i18n.patch" || die "gettext fix"
	# bug 193458
	epatch "${FILESDIR}/${PN}-3.2-gi18n.patch" || die

	# Fix deprecated API disabling in used glib library - this is not future-proof, bug 210657
	sed -i -e '/G_DISABLE_DEPRECATED/d' \
		"${S}/src/Makefile.am" "${S}/src/Makefile.in" \
		"${S}/components/html-editor/Makefile.am" "${S}/components/html-editor/Makefile.in"

	sed -i -e 's:-DGTK_DISABLE_DEPRECATED=1 -DGDK_DISABLE_DEPRECATED=1 -DG_DISABLE_DEPRECATED=1 -DGNOME_DISABLE_DEPRECATED=1::g' \
		"${S}/a11y/Makefile.am" "${S}/a11y/Makefile.in"
}
