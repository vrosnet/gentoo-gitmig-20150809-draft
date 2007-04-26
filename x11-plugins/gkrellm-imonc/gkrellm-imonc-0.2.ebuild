# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-imonc/gkrellm-imonc-0.2.ebuild,v 1.5 2007/04/26 19:12:16 armin76 Exp $

inherit gkrellm-plugin

IUSE=""
DESCRIPTION="A GKrellM2 plugin to control a fli4l router"
SRC_URI="mirror://sourceforge/${PN}/${PN}-src-${PV}.tar.bz2"
RESTRICT="nomirror"
HOMEPAGE="http://gkrellm-imonc.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

S=${WORKDIR}/${PN}-src-${PV}

