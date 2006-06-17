# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-yaepg/vdr-yaepg-0.0.2.1.ebuild,v 1.3 2006/06/17 19:07:42 squinky86 Exp $

inherit vdr-plugin eutils


MY_P=${VDRPLUGIN}-${PV}-rev2

DESCRIPTION="Video Disk Recorder ${VDRPLUGIN} Plugin"
HOMEPAGE="http://www.hoochvdr.info/"
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2
		mirror://gentoo/${MY_P}.patch"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND=">=media-video/vdr-1.2.6"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	vdr-plugin_pkg_setup

	einfo "Checking driver"
	grep -q OSD_OpenRaw ${DVB_INCLUDE_DIR}/linux/dvb/*.h
	eend $? "You need to update your DVB-Driver!" || die "Too old DVB-Driver installed!"

	einfo "Checking for patched vdr"
	grep -q fontYaepg ${VDR_INCLUDE_DIR}/vdr/font.h
	eend $? "You need to emerge vdr with use-flag yaepg set!" || die "Unpatched vdr detected!"
}

src_unpack() {
	vdr-plugin_src_unpack
	epatch ${DISTDIR}/${VDRPLUGIN}-${PV}-rev2.patch
}

