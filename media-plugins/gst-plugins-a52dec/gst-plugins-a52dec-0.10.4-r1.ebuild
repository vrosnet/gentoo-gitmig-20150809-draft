# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-a52dec/gst-plugins-a52dec-0.10.4-r1.ebuild,v 1.2 2007/02/16 13:09:15 uberlord Exp $

inherit gst-plugins-ugly

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/a52dec-0.7.3
	>=media-libs/gst-plugins-base-0.10.3
	>=media-libs/gstreamer-0.10.3"

DEPEND="${RDEPEND}"

src_unpack() {
	gst-plugins-ugly_src_unpack
	cd ${S}
	epatch ${FILESDIR}/gsta52-audio-volume.patch
}
