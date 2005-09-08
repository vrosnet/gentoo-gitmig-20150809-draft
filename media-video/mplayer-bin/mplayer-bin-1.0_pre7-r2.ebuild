# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mplayer-bin/mplayer-bin-1.0_pre7-r2.ebuild,v 1.2 2005/09/08 20:23:19 dang Exp $

inherit multilib

DESCRIPTION="Pre-build mplayer binary for amd64 systems"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${PF}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""

RDEPEND=">=app-emulation/emul-linux-x86-baselibs-2.0
	>=app-emulation/emul-linux-x86-soundlibs-2.2
	>=app-emulation/emul-linux-x86-gtklibs-2.1
	>=app-emulation/emul-linux-x86-sdl-2.1
	>=app-emulation/emul-linux-x86-medialibs-1.1-r1
	>=media-libs/win32codecs-20050412"

S=${WORKDIR}

pkg_setup() {
	# This is a binary x86 package => ABI=x86
	# Please keep this in future versions
	# Daniel Gryniewicz <dang@gentoo.org>
	has_multilib_profile || die
	ABI="x86"
}

src_install() {
	cp -pPRvf ${WORKDIR}/* ${D}/
	dosym /opt/mplayer-bin/bin/mplayer-bin /opt/mplayer-bin/bin/gmplayer-bin
	dodir /opt/mplayer-bin/lib
	dosym /usr/$(get_libdir)/win32 /opt/mplayer-bin/lib/win32
}
