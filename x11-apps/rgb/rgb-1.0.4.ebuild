# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/rgb/rgb-1.0.4.ebuild,v 1.1 2010/10/08 11:18:55 scarabeus Exp $

EAPI=3
XORG_STATIC=no
inherit xorg-2

DESCRIPTION="uncompile an rgb color-name database"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris ~x86-winnt"
IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}
	x11-proto/xproto"
