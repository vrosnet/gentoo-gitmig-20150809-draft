# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/dnstracer/dnstracer-1.8.ebuild,v 1.5 2005/01/01 06:36:57 j4rg0n Exp $

inherit flag-o-matic

DESCRIPTION="Determines where a given nameserver gets its information from"
SRC_URI="http://www.mavetju.org/download/${P}.tar.gz"
HOMEPAGE="http://www.mavetju.org/unix/general.php"

IUSE="ipv6"
KEYWORDS="x86 ~ppc sparc ~s390 ~amd64 ~ppc-macos"
LICENSE="as-is"
SLOT="0"
DEPEND="virtual/libc"
RDEPEND=""

src_compile () {
	if use ppc-macos; then
		append-flags "-DBIND_8_COMPAT=1"
	fi

	econf `use_enable ipv6` || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc README CHANGES
}

