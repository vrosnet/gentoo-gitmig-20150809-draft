# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gtkdialog/gtkdialog-0.8.0.ebuild,v 1.1 2011/10/12 18:04:19 ssuominen Exp $

EAPI=4

DESCRIPTION="A small utility for fast and easy GUI building"
HOMEPAGE="http://code.google.com/p/gtkdialog/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	gnome-base/libglade"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/flex
	virtual/yacc"

DOCS=( AUTHORS ChangeLog TODO )
