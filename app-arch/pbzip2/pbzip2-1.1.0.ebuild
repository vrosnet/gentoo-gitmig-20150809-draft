# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/pbzip2/pbzip2-1.1.0.ebuild,v 1.1 2010/03/13 23:35:03 spatz Exp $

EAPI=2

inherit multilib eutils

DESCRIPTION="parallel bzip2 (de)compressor using libbz2"
HOMEPAGE="http://compression.ca/pbzip2/"
SRC_URI="http://compression.ca/${PN}/${P}.tar.gz"

LICENSE="PBZIP2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="static symlink"

DEPEND="app-arch/bzip2"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch
	tc-export CXX
}

src_compile() {
	if use static ; then
		cp -f /usr/$(get_libdir)/libbz2.a "${S}"
		emake pbzip2-static || die "Failed to build"
	else
		emake pbzip2 || die "Failed to build"
	fi
}

src_install() {
	dobin pbzip2 || die "Failed to install"
	dodoc AUTHORS ChangeLog README
	doman pbzip2.1 || die "Failed to install man page"
	dosym /usr/bin/pbzip2 /usr/bin/pbunzip2

	if use symlink; then
		dosym /usr/bin/pbzip2 /usr/bin/bzip2
		dosym /usr/bin/pbzip2 /usr/bin/bunzip2
		dosym /usr/bin/pbzip2 /usr/bin/bzcat
	fi
}
