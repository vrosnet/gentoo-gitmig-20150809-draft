# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wklej/wklej-0.0.5.ebuild,v 1.4 2007/06/21 06:45:39 opfer Exp $

DESCRIPTION="a wklej.org submitter supporting UTF-8"
HOMEPAGE="http://wklej.org"
SRC_URI="http://wklej.org/apps/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-lang/perl
		dev-perl/libwww-perl"
RDEPEND="${DEPEND}"

src_install() {
	dobin ${WORKDIR}/${P}.pl
	dosym ${P}.pl /usr/bin/${PN}
}
