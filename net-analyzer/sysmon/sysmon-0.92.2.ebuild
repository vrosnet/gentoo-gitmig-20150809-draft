# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sysmon/sysmon-0.92.2.ebuild,v 1.1 2006/03/23 19:21:54 kingtaco Exp $

inherit eutils

DESCRIPTION="Sysmon - Simple network monitoring tool"
HOMEPAGE="http://www.sysmon.org/"
SRC_URI="ftp://puck.nether.net/pub/jared/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-amd64 ~x86"
IUSE=""

DEPEND="sys-libs/ncurses
	net-analyzer/net-snmp"
RDEPEND="${DEPEND}"

src_install() {
	cd ${S}
	einstall || die

	doinitd ${FILESDIR}/sysmond
	dodoc docs/*
}
