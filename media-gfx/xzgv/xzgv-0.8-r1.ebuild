# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xzgv/xzgv-0.8-r1.ebuild,v 1.8 2005/05/21 03:04:49 yoswink Exp $

inherit eutils

DESCRIPTION="An X image viewer."
SRC_URI="ftp://ftp.ibiblio.org/pub/Linux/apps/graphics/viewers/X/${P}.tar.gz"
HOMEPAGE="http://rus.members.beeb.net/xzgv.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ~ppc amd64 ~ppc64 ~hppa ~alpha"
IUSE=""

DEPEND="virtual/x11
	sys-apps/gawk
	media-libs/libpng
	media-libs/jpeg
	media-libs/tiff
	sys-libs/zlib
	=x11-libs/gtk+-1.2*
	>=media-libs/imlib-1.0"

src_unpack() {
	unpack ${A}

	cd ${S}
	cp config.mk config.mk.orig
	sed -i -e "s:-O2 -Wall:${CFLAGS}:" config.mk

	case "${ARCH}" in
		"x86")
			;;
		*)
			sed -i -e "s/CFLAGS+=-DINTERP_MMX/#&/" config.mk
			;;
	esac

	# Fix for bug #74069
	epatch ${FILESDIR}/${P}-integer-overflow-fix.diff
}

src_compile() {
	emake || die
}

src_install() {
	dodir /usr/bin /usr/share/info /usr/share/man/man1
	make PREFIX=${D}/usr \
		 SHARE_INFIX=/share \
		 INFO_DIR_UPDATE=no \
		 MANDIR=${D}/usr/share/man/man1 \
	     install || die

	# Fix info files
	cd ${D}/usr/share/info
	for i in 1 2 3
	do
		mv xzgv-$i.gz xzgv.info-$i.gz
	done
	gzip -dc xzgv.gz | \
		sed -e 's:^xzgv-:xzgv\.info-:g' | \
		gzip -9c > xzgv.info.gz
	rm xzgv.gz

	cd ${S}

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README* TODO
}
