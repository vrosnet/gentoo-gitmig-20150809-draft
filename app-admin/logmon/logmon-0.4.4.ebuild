# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/logmon/logmon-0.4.4.ebuild,v 1.2 2006/01/10 17:50:50 dang Exp $

MY_P="LogMon-${PV}"
DESCRIPTION="Split-screen terminal/ncurses based log viewer"
HOMEPAGE="http://www.edespot.com/code/LogMon/"
SRC_URI="http://www.edespot.com/code/LogMon/${MY_P}.tar.bz2"

S="${WORKDIR}/${MY_P}"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-libs/ncurses"

src_install() {
	dobin logmon || die
	dodoc AUTHORS ChangeLog README TODO
}
