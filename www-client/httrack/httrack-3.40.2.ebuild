# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/httrack/httrack-3.40.2.ebuild,v 1.3 2006/03/17 03:32:19 chriswhite Exp $

MY_P="${PN}_${PV}"
DESCRIPTION="HTTrack Website Copier, Open Source Offline Browser"
HOMEPAGE="http://www.httrack.com/"
SRC_URI="http://debian.httrack.com/dists/unstable/main/source/${MY_P}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE=""

src_compile() {
	econf || die
	# won't compile in parallel
	emake -j1 || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS README greetings.txt history.txt
	dohtml httrack-doc.html
}
