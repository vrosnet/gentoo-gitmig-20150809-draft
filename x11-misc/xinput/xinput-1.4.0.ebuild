# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xinput/xinput-1.4.0.ebuild,v 1.4 2009/04/03 13:53:46 ranger Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="Utility to set XInput device parameters"
SRC_URI="http://xorg.freedesktop.org/archive/individual/app/${P}.tar.bz2"
LICENSE="as-is"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~mips ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""
RDEPEND="
	  x11-libs/libX11
	  x11-libs/libXext
	>=x11-libs/libXi-1.2"
DEPEND="${RDEPEND}
	>=x11-proto/inputproto-1.5"
