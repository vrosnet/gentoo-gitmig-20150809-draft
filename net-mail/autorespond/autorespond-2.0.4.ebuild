# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/autorespond/autorespond-2.0.4.ebuild,v 1.8 2004/06/24 23:19:26 agriffis Exp $

inherit eutils

S=${WORKDIR}/${P}
DESCRIPTION="Autoresponder add on package for qmailadmin"
DEBIAN_PV="1"
DEBIAN_P="${P/-/_}-${DEBIAN_PV}"
SRC_URI="mirror://sourceforge/qmailadmin/${P}.tar.gz
		 mirror://debian/pool/contrib/${PN:0:1}/${PN}/${DEBIAN_P}.diff.gz"
HOMEPAGE="http://inter7.com/devel/"
KEYWORDS="~x86 alpha ~hppa ia64 ~mips ~ppc ~sparc amd64"
LICENSE="GPL-2"
SLOT="0"
RDEPEND="mail-mta/qmail"
DEPEND="sys-devel/gcc virtual/glibc"

src_unpack() {
	unpack ${P}.tar.gz
	epatch ${DISTDIR}/${DEBIAN_P}.diff.gz
}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install () {
	into /var/qmail
	dobin autorespond
	into /usr
	dodoc README help_message qmail-auto ChangeLog
	doman *.1
}
