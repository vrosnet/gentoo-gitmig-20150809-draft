# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/qmail-qfilter/qmail-qfilter-1.5.ebuild,v 1.1 2003/08/01 04:44:26 robbat2 Exp $

S=${WORKDIR}/${P}
DESCRIPTION="qmail-queue multi-filter front end"
SRC_URI="http://untroubled.org/qmail-qfilter/${P}.tar.gz"
HOMEPAGE="http://untroubled.org/qmail-qfilter/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc"

DEPEND="virtual/glibc"
RDEPEND=">=net-mail/qmail-1.03-r8"

QMAIL_BINDIR="/var/qmail/bin/"

src_compile() {
	cd ${S}
	echo "${CC} ${CFLAGS}" > conf-cc
	echo "${CC}" > conf-ld
	echo "${D}${QMAIL_BINDIR}" > conf-bin
	echo "${D}/usr/share/man/" > conf-man
	emake || die
}

src_install () {
	dodir ${QMAIL_BINDIR} /usr/share/man/
	./installer || die "Installer failed"
	dodoc ANNOUNCEMENT FILES NEWS README TARGETS TODO VERSION
	dointo sample
	dodoc sample/*
}

pkg_postinst() {
	einfo "Please see /usr/share/doc/${PF}/README for configuration information"
}
