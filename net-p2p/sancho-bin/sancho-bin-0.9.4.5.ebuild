# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/sancho-bin/sancho-bin-0.9.4.5.ebuild,v 1.1 2004/06/16 01:33:46 squinky86 Exp $

IUSE="gtk2"

MY_P=${P/-bin/}
MY_P=${MY_P%.*}-${MY_P##*.}

use gtk2 && TOOLKIT="gtk" || TOOLKIT="fox"

DESCRIPTION="a powerful frontend for mldonkey"
HOMEPAGE="http://sancho-gui.sourceforge.net/"
SRC_URI="http://sancho-gui.sourceforge.net/tmp/${MY_P}-linux-${TOOLKIT}.tar.bz2"

KEYWORDS="~x86"
SLOT="0"
LICENSE="CPL-1.0 LGPL-2.1"
RESTRICT="nomirror"

DEPEND="virtual/glibc
	virtual/x11
	gtk2? ( >=x11-libs/gtk+-2 )"

S="${WORKDIR}/${MY_P}-linux-${TOOLKIT}"

src_compile() {
	einfo "Nothing to compile."
}

src_install() {
	dodir /opt/sancho
	dodir /opt/bin

	cd ${S}
	cp -dpR sancho distrib lib ${D}/opt/sancho

	exeinto /opt/sancho
	doexe sancho-bin

	exeinto /opt/bin
	newexe ${FILESDIR}/sancho.sh sancho

	dodir /etc/env.d
	echo -e "PATH=/opt/sancho\n" > ${D}/etc/env.d/20sancho
}

pkg_postinst() {
	einfo
	einfo "Sancho requires the presence of a p2p core, like"
	einfo "net-p2p/mldonkey, in order to operate."
	einfo
}
