# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/openquicktime/openquicktime-1.0-r1.ebuild,v 1.5 2003/10/02 15:37:48 phosphan Exp $

inherit flag-o-matic
replace-flags "-fprefetch-loop-arrays" " "

MY_P=${P}-src
S=${WORKDIR}/${MY_P}
DESCRIPTION="OpenQuicktime library for linux"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tgz"
HOMEPAGE="http://openquicktime.sourceforge.net/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ppc sparc ~alpha amd64"

DEPEND="media-sound/lame
	media-sound/mpg123
	=dev-libs/glib-1*
	!virtual/quicktime
	media-libs/jpeg"

PROVIDES="virtual/quicktime"

src_compile() {

	./configure \
		--enable-debug=no \
		--prefix=/usr || die # Disable debug - enabled by default

	make || die
}

src_install() {
	cd ${S}
	dolib.so libopenquicktime.so
	dodoc README AUTHORS NEWS COPYING TODO
	dodir /usr/bin
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		docdir=${D}/usr/share/doc/${PF}/html \
		sysconfdir=${D}/etc \
		install || die
}
