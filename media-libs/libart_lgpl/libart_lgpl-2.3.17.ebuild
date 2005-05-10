# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libart_lgpl/libart_lgpl-2.3.17.ebuild,v 1.5 2005/05/10 14:00:26 gustavoz Exp $

inherit gnome2

DESCRIPTION="a LGPL version of libart"
HOMEPAGE="http://www.levien.com/libart"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ia64 ~mips ppc ~ppc-macos ~ppc64 ~s390 sparc x86"
IUSE=""

DEPEND="dev-util/pkgconfig"
RDEPEND="virtual/libc"
# Add the RDEPEND so we dont have a runtime dep on pkg-config

DOCS="AUTHORS ChangeLog INSTALL NEWS README"
