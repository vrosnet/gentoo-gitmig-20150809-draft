# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyframer/pyframer-0.2.ebuild,v 1.1 2002/12/12 14:03:25 lordvan Exp $

IUSE=""
S=${WORKDIR}/${P}
DESCRIPTION="Python interface for framerd"
SRC_URI="http://twistedmatrix.com/users/washort/pyframer/${P}.tar.gz"
HOMEPAGE="http://twistedmatrix.com/users/washort/pyframer/"
LICENSE="LGPL-2.1"
SLOT="0"
RDEPEND="virtual/python
	>=dev-db/framerd-2.4.3"
DEPEND="$RDEPEND"
KEYWORDS="~x86"

inherit distutils

src_install() {
    distutils_src_install
    dodoc README.txt
}

