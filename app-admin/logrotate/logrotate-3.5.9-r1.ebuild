# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/logrotate/logrotate-3.5.9-r1.ebuild,v 1.8 2002/10/18 13:31:45 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Rotates, compresses, and mails system logs"
SRC_URI="http://ftp.debian.org/debian/pool/main/l/${PN}/${PN}_${PV}.orig.tar.gz"
HOMEPAGE="http://packages.debian.org/unstable/admin/logrotate.html"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND=">=dev-libs/popt-1.5"
RDEPEND="${DEPEND}"

src_compile() {
	cp Makefile Makefile.orig
	sed -e "s:CFLAGS += -g:CFLAGS += -g ${CFLAGS}:" Makefile.orig > Makefile
	make || die
}

src_install() {
	insinto /usr
	dosbin logrotate
	doman logrotate.8
	dodoc examples/logrotate*
}

pkg_postinst() {
	einfo "If you wish to have logrotate e-mail you updates, please"
	einfo "emerge net-mail/mailx"
}
