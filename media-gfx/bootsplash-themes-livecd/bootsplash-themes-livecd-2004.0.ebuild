# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/bootsplash-themes-livecd/bootsplash-themes-livecd-2004.0.ebuild,v 1.8 2005/05/02 12:46:06 wolf31o2 Exp $

IUSE="livecd"
S=${WORKDIR}/bootsplash-themes-livecd-${PV}
DESCRIPTION="Gentoo theme for bootsplash consoles"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="http://dev.gentoo.org/~wolf31o2/sources/${PN}/${PF}.tar.bz2"

SLOT=${PV}
LICENSE="GPL-2"
KEYWORDS="x86 amd64"

DEPEND=">=media-gfx/bootsplash-0.6-r16"

src_install() {
	dodir /etc/bootsplash/livecd-${PV}
	cp -r ${S}/* ${D}/etc/bootsplash/livecd-${PV}

	# link default config for livecd images if USE=livecd set
	use livecd \
		&& cd ${D}/etc/bootsplash \
		&& rm default \
		&& dosym ./livecd-${PV} /etc/bootsplash/default
}
