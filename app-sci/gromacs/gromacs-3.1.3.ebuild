# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/gromacs/gromacs-3.1.3.ebuild,v 1.7 2002/10/20 18:40:37 vapier Exp $

DESCRIPTION="The ultimate Molecular Dynamics simulation package"

SRC_URI="ftp://ftp.gromacs.org/pub/gromacs/${P}.tar.gz"

HOMEPAGE="http://www.gromacs.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=dev-libs/fftw-2.1.3
		>=sys-devel/binutils-2.10.91.0.2"


src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr/gromacs \
		--includedir=/usr/include/gromacs \
		--infodir=/usr/share/info \
		--enable-fortran \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	# Install documentation.
	dodoc AUTHORS COPYING INSTALL README

	#move html docs under /usr/share/doc
	#and leave examples and templates under /usr/gromacs...
	mv ${D}/usr/gromacs/share/html ${D}/usr/share/doc/${P}
	
}
