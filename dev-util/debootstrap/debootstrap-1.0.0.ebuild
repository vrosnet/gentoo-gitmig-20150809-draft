# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/debootstrap/debootstrap-1.0.0.ebuild,v 1.1 2007/06/25 16:45:55 solar Exp $

DESCRIPTION="Debian/Ubuntu bootstrap scripts"
HOMEPAGE="http://packages.qa.debian.org/d/debootstrap.html"
SRC_URI="http://archive.ubuntu.com/ubuntu/pool/main/d/debootstrap/debootstrap_${PV}.tar.gz mirror://gentoo/devices.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~x86"
IUSE=""

DEPEND="sys-devel/binutils
	net-misc/wget
	app-arch/dpkg"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack debootstrap_${PV}.tar.gz
	cp "${DISTDIR}"/devices.tar.gz "${S}"/devices-std.tar.gz || die
}

src_compile() {
	emake pkgdetails debootstrap-arch || die
}

src_install() {
	make DESTDIR="${D}" install-allarch || die
	dodoc TODO
}
