# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/win32codecs/win32codecs-0.90.1-r1.ebuild,v 1.6 2004/06/24 23:25:33 agriffis Exp $

# Update codec pack from:
#
#   http://www.mplayerhq.hu/MPlayer/releases/codecs/win32codecs.tar.bz2

S="${WORKDIR}/${PN}"
DESCRIPTION="Win32 binary codecs for MPlayer and maybe avifile as well"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	quicktime? ( mirror://gentoo/qt6dlls-${PV}.tar.bz2 )"
HOMEPAGE="http://www.mplayerhq.hu/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 -ppc -sparc"
IUSE="quicktime"

src_install() {
	insinto /usr/lib/win32
	doins ${S}/*
	use quicktime && doins ${WORKDIR}/qt6dlls/*
}
