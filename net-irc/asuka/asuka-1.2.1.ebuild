# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/asuka/asuka-1.2.1.ebuild,v 1.5 2007/02/24 13:41:37 nixnut Exp $

inherit eutils

DESCRIPTION="The QuakeNet IRC Server"
HOMEPAGE="http://dev-com.quakenet.org/"
SRC_URI="http://dev-com.quakenet.org/releases/${PN}/${PV}/${P}.tar.bz2"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="x86 sparc"

IUSE="debug"
DEPEND="virtual/libc"

src_compile() {
	econf \
		--with-symlink=asuka-ircd \
		--with-dpath=/etc/asuka \
		--with-cpath=/etc/asuka/ircd.conf \
		--with-lpath=/var/log/asuka/asuka.log \
		$(use_enable debug) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	newbin ircd/ircd asuka-ircd || die "newbin failed"
	newman doc/ircd.8 asuka-ircd.8 || die "newman failed"

	insinto /etc/asuka
	doins doc/ircd.conf.sample || die "doins failed"

	newinitd ${FILESDIR}/asuka.init.d asuka || die "newinitd failed"
	newconfd ${FILESDIR}/asuka.conf.d asuka || die "newconfd failed"

	keepdir /var/log/asuka

	dodoc \
		INSTALL* LICENSE README* RELEASE.NOTES TODO* \
		doc/readme.* doc/p10.html doc/features.txt doc/Authors \
		|| die "dodoc failed"
}

pkg_postinst() {
	enewuser asuka
	chown asuka ${ROOT}/var/log/asuka

	einfo
	einfo "A sample config file can be found at /etc/asuka/ircd.conf.sample"
	einfo
}
