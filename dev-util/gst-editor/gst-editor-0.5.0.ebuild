# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gst-editor/gst-editor-0.5.0.ebuild,v 1.3 2003/03/31 21:26:33 foser Exp $

inherit gnome2

DESCRIPTION="GStreamer graphical pipeline editor"
SRC_URI="mirror://sourceforge/gstreamer/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND=">=media-libs/gstreamer-0.6
	>=x11-libs/gtk+-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libbonoboui-2
	>=gnome-base/libglade-2"

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=dev-util/pkgconfig-0.9"

DOCS="AUTHORS COPYING ChangeLog HACKING IDEAS NEWS README RELEASE TODO"
