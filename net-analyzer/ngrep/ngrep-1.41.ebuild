# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ngrep/ngrep-1.41.ebuild,v 1.11 2004/07/08 22:54:37 eldad Exp $

inherit eutils

IUSE=""
DESCRIPTION="A grep for network layers"
SRC_URI="mirror://sourceforge/ngrep/${P}.tar.bz2"
RESTRICT="nomirror"
HOMEPAGE="http://ngrep.sourceforge.net"

DEPEND="virtual/libc
	>=net-libs/libpcap-0.5.2
	sys-devel/autoconf"

RDEPEND="virtual/libc"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc alpha amd64"

src_unpack() {
	unpack ${A} ; cd ${S}
	epatch ${FILESDIR}/${P}-libpcap-include.patch
	epatch ${FILESDIR}/${P}-fix-HAVE_DUMB_UDPHDR-test.patch
}

src_compile() {
	autoconf

	econf || die
	make || die
}

src_install() {
	into /usr
	dobin ngrep
	doman ngrep.8
	dodoc BUGS CHANGES COPYRIGHT CREDITS README TODO USAGE
}
