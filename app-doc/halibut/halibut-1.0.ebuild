# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/halibut/halibut-1.0.ebuild,v 1.2 2010/06/16 04:03:25 mr_bones_ Exp $

inherit toolchain-funcs

DESCRIPTION="yet another free document preparation system"
HOMEPAGE="http://www.chiark.greenend.org.uk/~sgtatham/halibut/"
SRC_URI="http://www.chiark.greenend.org.uk/~sgtatham/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

src_compile() {
	tc-export CC
	CFLAGS="${CFLAGS} ${CPPFLAGS}" \
	LFLAGS="${LDFLAGS}" \
	emake -j1 \
		BUILDDIR="${S}/build" \
		VERSION="${PV}" \
		|| die "make failed"

	emake -C doc || die "make in doc failed"
}

src_install() {
	dobin build/halibut || die
	doman doc/halibut.1 || die
	dodoc doc/halibut.txt
	dohtml doc/*.html
}
