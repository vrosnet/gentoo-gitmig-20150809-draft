# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/nedit/nedit-5.4_pre20030213.ebuild,v 1.7 2003/10/24 12:55:26 aliz Exp $

inherit eutils

S=${WORKDIR}/${PN}
DESCRIPTION="multi-purpose text editor for the X Window System"
HOMEPAGE="http://nedit.org/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc"
IUSE="spell"

RDEPEND="spell? ( virtual/aspell-dict )"
DEPEND="${RDEPEND}
	dev-util/yacc
	virtual/motif"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/nedit-5.3-gentoo.diff

	sed -i "s:-O:${CFLAGS} -D__LINUX__:" \
		${S}/makefiles/Makefile.linux
}

src_compile() {
	make CC=${CC} linux || die
}

src_install() {
	into /usr
	dobin source/nedit
	exeinto /usr/bin
	newexe source/nc neditc
	newman doc/nedit.man nedit.1
	newman doc/nc.man neditc.1

	dodoc README ReleaseNotes ChangeLog COPYRIGHT
	cd doc
	dodoc *.txt nedit.doc README.FAQ NEdit.ad
	dohtml *.{dtd,xsl,xml,html,awk}
}
