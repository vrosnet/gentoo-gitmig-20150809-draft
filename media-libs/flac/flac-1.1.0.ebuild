# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/flac/flac-1.1.0.ebuild,v 1.2 2003/02/11 00:00:13 agriffis Exp $

IUSE="sse xmms"

inherit libtool

DESCRIPTION="FLAC is a free lossless audio encoder which includes an XMMS plugin."
SRC_URI="mirror://sourceforge/flac/${P}.tar.gz"
HOMEPAGE="http://flac.sourceforge.net/"
S=${WORKDIR}/${P}

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

RDEPEND="virtual/glibc 
	>=media-libs/libogg-1.0_rc2
	xmms? ( media-sound/xmms )"

DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm ) 
	sys-apps/gawk"

src_compile() {

	use xmms || {
		cp src/Makefile.in src/Makefile.in.orig
		sed -e '/^@FLaC__HAS_XMMS_TRUE/d' \
			src/Makefile.in.orig > src/Makefile.in
	}

	elibtoolize --reverse-deps

	local myconf

	use sse && myconf="--enable-sse"

	econf ${myconf} || die 
	cp Makefile Makefile.orig

	#the man page ebuild requires docbook2man... yick!
	sed -e 's:include man:include:g' Makefile.orig > Makefile

	#emake seems to mess up the building of the xmms input plugin
	make || die

}
src_install() {
	make DESTDIR=${D} install
}
