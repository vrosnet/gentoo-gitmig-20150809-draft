# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/blender/blender-2.23-r1.ebuild,v 1.6 2004/06/24 22:33:42 agriffis Exp $

S=${WORKDIR}/blender-creator-${PV}-linux-glibc2.1.2-i386
DESCRIPTION="Extremely fast and versatile 3D rendering package"
SRC_URI="http://www.download.blender.pl/mirror/blender-creator-${PV}-linux-glibc2.1.2-i386.tar.gz http://www.download.blender.pl/mirror/manual_1.5.zip"
HOMEPAGE="http://www.blender.org"

SLOT="0"
LICENSE="blender"
KEYWORDS="x86 -ppc -sparc "

DEPEND="app-arch/unzip"
RDEPEND="virtual/x11
		sys-libs/lib-compat"

src_install () {
	dodir /opt
	cd ${D}/opt
	tar xzf ${DISTDIR}/blender-creator-${PV}-linux-glibc2.1.2-i386.tar.gz
	mv blender-creator-${PV}-linux-glibc2.1.2-i386 blender-${PV}
	dodir /usr/share/doc/${P}
	cd ${D}/usr/share/doc/${P}
	unzip ${DISTDIR}/manual_1.5.zip
	mv manual_1.5 html
	insinto /usr/bin
	insopts -m755
	newins ${FILESDIR}/${P} blender
	dodir /usr/bin
	dosym /opt/blender-${PV}/blender /usr/bin/blender

	dodoc README
}
