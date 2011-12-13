# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nmbscan/nmbscan-1.2.5.ebuild,v 1.3 2011/12/13 23:18:28 ago Exp $

EAPI=2

inherit eutils

DESCRIPTION="netbios scanner"
HOMEPAGE="http://nmbscan.gbarbier.org/"
SRC_URI="http://nmbscan.gbarbier.org/down/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc x86"
IUSE=""

DEPEND=""
RDEPEND="app-shells/bash
	net-dns/bind-tools
	net-fs/samba
	net-misc/iputils
	sys-apps/coreutils
	sys-apps/gawk
	sys-apps/grep
	sys-apps/net-tools
	sys-apps/sed"

src_prepare() {
	epatch "${FILESDIR}"/${P}-head.diff || die
}

src_configure() {
	return
}

src_compile() {
	return
}

src_install() {
	dobin nmbscan || die
}
