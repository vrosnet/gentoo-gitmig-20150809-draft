# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/wasabi/wasabi-0.2.1-r1.ebuild,v 1.1 2004/06/24 16:20:05 klieber Exp $

DESCRIPTION="Log parsing and notification program"
HOMEPAGE="http://www.gentoo.org/~lcars/wasabi"
SRC_URI="http://www.gentoo.org/~lcars/wasabi/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""

RDEPEND="dev-lang/perl
		sys-apps/coreutils"

pkg_preinst() {
	enewgroup wasabi
	enewuser  wasabi -1 /bin/false /var/lib/wasabi wasabi
	fowners wasabi:root /etc/wasabi/wasabi.conf
	fowners wasabi:root /var/lib/wasabi
}

src_install() {
	sed -i -e "s:-o wasabi::" Makefile
	emake DESTDIR=${D} install
	doman wasabi.8
	exeinto /etc/init.d
	newexe wasabi.gentoo-init wasabi
	keepdir /var/lib/wasabi
}
