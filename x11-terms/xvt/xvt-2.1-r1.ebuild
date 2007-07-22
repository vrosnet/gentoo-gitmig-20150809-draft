# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/xvt/xvt-2.1-r1.ebuild,v 1.5 2007/07/22 05:56:56 dberkholz Exp $

inherit ccc eutils flag-o-matic

DESCRIPTION="A tiny vt100 terminal emulator for X"
HOMEPAGE="ftp://ftp.x.org/R5contrib/xvt-1.0.README"
SRC_URI="ftp://ftp.x.org/R5contrib/xvt-1.0.tar.Z
		mirror://gentoo/xvt-2.1.diff.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ppc"
IUSE=""
RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}
	x11-proto/xproto"
S=${WORKDIR}/${PN}-1.0

src_unpack() {
	unpack ${A}

	# this brings the distribution upto version 2.1
	cd ${S}
	epatch ${WORKDIR}/xvt-2.1.diff

	# fix #61393
	epatch ${FILESDIR}/xvt-ttyinit-svr4pty.diff

	# set the makefile options
	sed -i 's/#\(ARCH=LINUX\)/\1/g' Makefile

	# set CFLAGS
	sed -i "s^\(CFLAGS=\)-O^\1${CFLAGS}^g" Makefile

	# add search path for X11 libs.
	append-ldflags -L/usr/X11R6/lib

	# make gcc quiet.
	sed -i -e 's/^void$/int/' -e 's/^void\( main\)/int\1/g' xvt.c

}

src_compile() {
	# emake -j1 config
	emake || die
}

src_install() {
	dobin xvt
	doman xvt.1
	dodoc README COPYING
}
