# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmatroska/libmatroska-0.4.4.ebuild,v 1.2 2004/01/03 19:20:58 plasmaroo Exp $

IUSE=""

S=${WORKDIR}/${P}

DESCRIPTION="Extensible multimedia container format based on EBML."
SRC_URI="http://matroska.sourceforge.net/downloads/${P}.tar.bz2"
HOMEPAGE="http://www.matroska.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="virtual/glibc
	~media-libs/libebml-${PV}"

src_compile() {
	cd ${S}/make/linux
	make PREFIX=/usr \
		LIBEBML_INCLUDE_DIR=/usr/include/ebml \
		LIBEBML_LIB_DIR=/usr/lib || die "make failed"
}

src_install () {
	cd ${S}/make/linux
	einstall || die "make install failed"
}

