# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/opengl-update/opengl-update-1.5.ebuild,v 1.6 2003/09/21 18:56:34 avenj Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Utility to change the OpenGL interface being used."
SRC_URI=""
HOMEPAGE="http://www.gentoo.org/"

KEYWORDS="x86 ppc sparc alpha arm hppa amd64 ia64"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"


src_install() {
	newsbin ${FILESDIR}/opengl-update-${PV} opengl-update
}

