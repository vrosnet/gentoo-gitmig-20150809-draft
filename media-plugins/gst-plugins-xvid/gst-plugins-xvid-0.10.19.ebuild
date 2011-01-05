# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-xvid/gst-plugins-xvid-0.10.19.ebuild,v 1.3 2011/01/05 16:23:28 hwoarang Exp $

inherit gst-plugins-bad

KEYWORDS="amd64 x86"
IUSE=""
DESCRIPTION="GStreamer plugin for XviD (MPEG-4) video encoding/decoding support"

RDEPEND="media-libs/xvid
	>=media-libs/gst-plugins-base-0.10.29"
DEPEND="${RDEPEND}"
