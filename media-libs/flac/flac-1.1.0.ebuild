# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/flac/flac-1.1.0.ebuild,v 1.23 2005/02/05 12:49:35 luckyduck Exp $

inherit libtool

DESCRIPTION="free lossless audio encoder which includes an XMMS plugin"
HOMEPAGE="http://flac.sourceforge.net/"
SRC_URI="mirror://sourceforge/flac/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64 mips"
IUSE="sse xmms X"

RDEPEND=">=media-libs/libogg-1.0_rc2
	X? ( xmms? ( media-sound/xmms ) )"

DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )
	sys-apps/gawk"

src_unpack() {
	unpack ${A}
	cd ${S}
	#if X not in use, then don't build in xmms support
	#if xmms not in use, then don't do it either.
	#if both X and xmms in use, then do it.
	if ! use xmms || ! use X
	then
		cp src/Makefile.in src/Makefile.in.orig
		sed -e '/^@FLaC__HAS_XMMS_TRUE/d' src/Makefile.in.orig > src/Makefile.in || die
	fi

	elibtoolize --reverse-deps
}

src_compile() {
	# hppa need -fPIC for to compile when X and xmss are in USE
	if use xmms && use X && [ "${ARCH}" = "hppa" ]
	then
		export CFLAGS="${CFLAGS} -fPIC"
	fi
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
	make DESTDIR=${D} install || die
}

# see #59482
src_test() { :; }
