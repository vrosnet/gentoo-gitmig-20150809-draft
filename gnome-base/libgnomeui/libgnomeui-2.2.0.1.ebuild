# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnomeui/libgnomeui-2.2.0.1.ebuild,v 1.5 2003/02/22 03:35:09 agriffis Exp $

IUSE="doc"

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="User interface part of libgnome"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
KEYWORDS="x86 ~ppc alpha"
LICENSE="GPL-2 LGPL-2" 

RDEPEND=">=x11-libs/pango-1.1.2
	>=sys-devel/perl-5.002
	>=sys-apps/gawk-3.1.0
	>=dev-libs/popt-1.5
	>=sys-devel/bison-1.28
	>=sys-devel/gettext-0.10.40
	>=media-sound/esound-0.2.26
	>=media-libs/audiofile-0.2.3
	>=gnome-base/libbonoboui-2
	>=gnome-base/gconf-1.2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomecanvas-2
	x11-themes/gnome-icon-theme
	x11-themes/gnome-themes"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-0.6 )"

DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README"
