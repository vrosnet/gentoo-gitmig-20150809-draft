# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bsdiff/bsdiff-4.3.ebuild,v 1.3 2005/09/24 16:23:19 ferringb Exp $

inherit toolchain-funcs

IUSE=""

DESCRIPTION="bsdiff: Binary Differencer using a suffix alg"
HOMEPAGE="http://www.daemonology.net/bsdiff/"
SRC_URI="http://www.daemonology.net/bsdiff/${P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc alpha ~hppa ~mips amd64 ia64"

DEPEND="app-arch/bzip2"

src_compile() {
	cd ${S}
	$(tc-getCC) -o bsdiff bsdiff.c -lbz2 || die "failed compiling bsdiff"
	$(tc-getCC) -o bspatch bspatch.c -lbz2 || die "failed compiling bspatch"
}

src_install() {
	insinto /usr
	dobin ${S}/bs{diff,patch}
	doman ${S}/bs{diff,patch}.1
}
