# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/cputnik/cputnik-0.1.1.ebuild,v 1.5 2006/01/22 11:24:46 nelchael Exp $

IUSE=""

DESCRIPTION="cputnik is a simple cpu monitor dockapp."
HOMEPAGE="http://clay.ll.pl/projects.html#dockapps"
SRC_URI="http://clay.ll.pl/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXpm )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( x11-proto/xextproto virtual/x11 )"

src_compile()
{
	make CFLAGS="${CFLAGS} -Iwmgeneral" || die "Compilation failed"
}

src_install()
{
	dobin cputnik
	dodoc AUTHORS Changelog README
}
