# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyopenal/pyopenal-0.1.3.ebuild,v 1.3 2004/03/30 01:17:17 dholm Exp $

inherit distutils

IUSE=""
MY_P=${P/pyopenal/PyOpenAL}

DESCRIPTION="OpenAL library port for Python"
SRC_URI="http://oomadness.tuxfamily.org/downloads/${MY_P}.tar.gz
	http://www.nectroom.homelinux.net/pkg/${MY_P}.tar.gz
	http://nectroom.homelinux.net/pkg/${MY_P}.tar.gz"
HOMEPAGE="http://oomadness.tuxfamily.org/en/pyopenal/"

KEYWORDS="~x86 ~ppc"
SLOT="0"
LICENSE="LGPL-2.1"

DEPEND=">=dev-lang/python-2.2.2
	media-libs/openal
	>=dev-python/pyvorbis-1.1
	>=dev-python/pyogg-1.1"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/pyopenal-1.3.patch
}
