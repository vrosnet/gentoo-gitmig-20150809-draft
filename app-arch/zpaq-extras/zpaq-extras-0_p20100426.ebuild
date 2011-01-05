# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/zpaq-extras/zpaq-extras-0_p20100426.ebuild,v 1.2 2011/01/05 23:30:36 mgorny Exp $

EAPI=3
inherit base toolchain-funcs

DESCRIPTION="A set of additional compression profiles for app-arch/zpaq"
HOMEPAGE="http://mattmahoney.net/dc/zpaq.html"
SRC_URI="http://mattmahoney.net/dc/bwt_j3.zip
	http://mattmahoney.net/dc/bwt_slowmode1.zip
	http://mattmahoney.net/dc/bmp_j4.zip
	http://mattmahoney.net/dc/exe_j1.zip
	http://mattmahoney.net/dc/jpg_test2.zip
	http://mattmahoney.net/dc/fast.cfg"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}

src_unpack() {
	default
	cp "${DISTDIR}"/fast.cfg . || die
}

src_configure() {
	sed \
		-e "s:^pcomp zpaq r:pcomp ${EPREFIX}/usr/bin/zpaq r${EPREFIX}/usr/share/zpaq/:" \
		-e "s:^pcomp \([^/]\):pcomp ${EPREFIX}/usr/libexec/zpaq/\1:" \
		-i *.cfg || die

	local sources=( *.cpp )
	# (the following assignment flattens the array)
	progs=${sources[@]%.cpp}
}

src_compile() {
	tc-export CXX
	emake ${progs} || die
}

src_install() {
	exeinto /usr/libexec/zpaq
	doexe ${progs} || die

	insinto /usr/share/zpaq
	doins *.cfg || die
}
