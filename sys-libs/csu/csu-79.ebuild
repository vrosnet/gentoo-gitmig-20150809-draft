# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/csu/csu-79.ebuild,v 1.1 2011/03/15 18:22:22 grobian Exp $

EAPI=3

DESCRIPTION="Darwin Csu (crt1.o) - Mac OS X 10.6.6 version"
HOMEPAGE="http://www.opensource.apple.com/"
SRC_URI="http://www.opensource.apple.com/tarballs/Csu/Csu-${PV}.tar.gz"

LICENSE="APSL-2"
RESTRICT="fetch"  # need to sort out if we can mirror

SLOT="0"
KEYWORDS="~ppc-macos"
IUSE=""

pkg_nofetch() {
	einfo "Please download the necessary files manually, it requires an"
	einfo "Apple Developer Connection account."
	einfo "  ${SRC_URI}"
	einfo "See: ${HOMEPAGE}"
}

src_prepare() {
	# since we don't have crt0, we can't build it either
	sed -i \
		-e 's:$(SYMROOT)/crt0.o::' \
		-e '/LOCLIBDIR)\/crt0.o/d' \
		Makefile || die
}

src_compile() {
	emake USRLIBDIR="${EPREFIX}"/lib || die
}

src_install() {
	emake \
		USRLIBDIR="${EPREFIX}"/lib \
		LOCLIBDIR="${EPREFIX}"/lib \
		DSTROOT="${D}" \
		install || die
}
