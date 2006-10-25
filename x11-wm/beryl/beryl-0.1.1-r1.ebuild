# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/beryl/beryl-0.1.1-r1.ebuild,v 1.1 2006/10/25 01:58:39 tsunam Exp $

inherit autotools

DESCRIPTION="Beryl window manager for AiGLX and XGL (meta)"
HOMEPAGE="http://beryl-project.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="x11-plugins/beryl-plugins
	x11-wm/emerald
	x11-misc/beryl-settings
	x11-misc/beryl-manager"

pkg_setup() {
	if ! built_with_use x11-libs/cairo X pdf ; then
		einfo "Please re-emerge x11-libs/cairo with the X and pdf USE flag set"
		die "Please emerge cairo with the X and pdf flag set"
	fi
}

