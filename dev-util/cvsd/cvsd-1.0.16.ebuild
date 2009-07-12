# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvsd/cvsd-1.0.16.ebuild,v 1.3 2009/07/12 18:13:17 halcy0n Exp $

inherit eutils

DESCRIPTION="CVS pserver daemon."
HOMEPAGE="http://ch.tudelft.nl/~arthur/cvsd/"
SRC_URI="http://ch.tudelft.nl/~arthur/cvsd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="tcpd"

DEPEND=">=dev-util/cvs-1.11.6
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"
RDEPEND="${DEPEND}
	>=dev-lang/perl-5.8.0"

pkg_setup() {
	enewgroup cvsd
	enewuser cvsd -1 -1 /var/lib/cvsd cvsd
}

src_compile() {
	econf $(use_with tcpd libwrap) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dosed 's:^Repos:# Repos:g' /etc/cvsd/cvsd.conf
	keepdir /var/lib/cvsd

	dodoc AUTHORS ChangeLog FAQ INSTALL NEWS README TODO

	newinitd "${FILESDIR}/cvsd.rc6" ${PN}
}

pkg_postinst() {
	elog "To configure cvsd please read the README in "
	elog "/usr/share/doc/${PF}/"
}
