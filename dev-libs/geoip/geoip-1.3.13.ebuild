# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/geoip/geoip-1.3.13.ebuild,v 1.2 2005/11/13 20:51:24 dragonheart Exp $

inherit flag-o-matic

MY_P=${P/geoip/GeoIP}
S=${WORKDIR}/${MY_P}

DESCRIPTION="easily lookup countries by IP addresses, even when Reverse DNS entries don't exist"
HOMEPAGE="http://www.maxmind.com/geoip/api/c.shtml"
SRC_URI="http://www.maxmind.com/download/geoip/api/c/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="virtual/libc
	sys-libs/zlib"

src_compile() {
	append-flags -fPIC
	econf --enable-shared || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
}
