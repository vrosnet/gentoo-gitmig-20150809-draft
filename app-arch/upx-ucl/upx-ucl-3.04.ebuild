# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/upx-ucl/upx-ucl-3.04.ebuild,v 1.1 2010/03/20 04:07:10 matsuu Exp $

EAPI="2"
inherit eutils toolchain-funcs flag-o-matic

LZMA_VER=465
#LZMA_VER=911
MY_P="${P/-ucl/}-src"
DESCRIPTION="upx is the Ultimate Packer for eXecutables."
HOMEPAGE="http://upx.sourceforge.net"
SRC_URI="http://upx.sourceforge.net/download/${MY_P}.tar.bz2
	mirror://sourceforge/sevenzip/lzma${LZMA_VER}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"

IUSE=""

DEPEND=">=dev-libs/ucl-1.02
	dev-lang/perl
	!app-arch/upx"

S="${WORKDIR}/${MY_P}"

src_compile() {
	#[ "$(tc-endian)" -eq "big" ] && append-flags "-D__BIG_ENDIAN__"
	use sparc && append-flags "-D__BIG_ENDIAN__"

	tc-export CXX
	emake UPX_LZMADIR="${WORKDIR}" all || die
}

src_install() {
	newbin src/upx.out upx || die

	dodoc BUGS NEWS PROJECTS README* THANKS TODO doc/upx.doc doc/*.txt || die
	dohtml doc/upx.html || die
	doman doc/upx.1 || die
}
