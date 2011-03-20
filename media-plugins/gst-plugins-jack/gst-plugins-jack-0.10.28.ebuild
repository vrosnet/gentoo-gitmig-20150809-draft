# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-jack/gst-plugins-jack-0.10.28.ebuild,v 1.1 2011/03/20 09:41:36 leio Exp $

inherit gst-plugins-good

DESCRIPION="GStreamer source/sink to transfer audio data with JACK ports"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.32
	>=media-sound/jack-audio-connection-kit-0.99.10"
DEPEND="${RDEPEND}"
