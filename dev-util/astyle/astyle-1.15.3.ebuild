# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/astyle/astyle-1.15.3.ebuild,v 1.10 2004/03/28 18:04:06 karltk Exp $

ZIP="astyle_${PV}.zip"
S=${WORKDIR}
DESCRIPTION="Artistic Style is a reindenter and reformatter of C++, C and Java
source code."
SRC_URI="mirror://sourceforge/astyle/${ZIP}"
HOMEPAGE="http://astyle.sourceforge.net"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 sparc "

DEPEND=">=app-arch/unzip-5.42"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/cmd-line-fix.diff
}

src_compile() {
	emake || die
}

src_install () {
	into /usr
	dobin astyle
	dohtml astyle.html astyle_release_notes.html license.html
	dodoc INSTALL.TXT
}
