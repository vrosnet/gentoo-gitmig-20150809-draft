# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-sanalyzer/xmms-sanalyzer-1.2.10.ebuild,v 1.6 2006/05/23 19:47:49 corsair Exp $

IUSE=""
SLOT="0"
KEYWORDS="alpha amd64 ~arm ~hppa ia64 ~mips ~ppc ppc64 sparc x86"

DEPEND=">=media-sound/xmms-1.2.10"

PLUGIN_PATH="Visualization/sanalyzer"

M4_VER="1.1"

inherit xmms-plugin
