# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/siege/siege-2.61_beta1.ebuild,v 1.2 2004/11/18 10:54:38 ka0ttic Exp $

inherit eutils

MY_P=${P/_beta/b}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A HTTP regression testing and benchmarking utility"
HOMEPAGE="http://www.joedog.org/siege/"
SRC_URI="ftp://sid.joedog.org/pub/${PN}/beta/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
SLOT="0"
IUSE="ssl"

DEPEND="ssl? ( >=dev-libs/openssl-0.9.6d )"
RDEPEND="${DEPEND}
	dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-2.60-gentoo.diff
}

src_compile() {
	einfo "Running autoreconf"
	autoreconf || die "autoreconf failed"
	econf $(use_with ssl) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL MACHINES README KNOWNBUGS \
		siegerc-example urls.txt || die "dodoc failed"
	use ssl && dodoc README.https
}
