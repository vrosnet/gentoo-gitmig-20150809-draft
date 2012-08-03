# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/i8kutils/i8kutils-1.33.ebuild,v 1.2 2012/08/03 13:26:06 ago Exp $

EAPI=4

inherit toolchain-funcs

DESCRIPTION="Dell Inspiron and Latitude utilities"
HOMEPAGE="http://packages.debian.org/sid/i8kutils"
SRC_URI="mirror://debian/pool/main/i/${PN}/${P/-/_}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* amd64 ~x86"
IUSE="examples tk"

DEPEND="tk? ( dev-lang/tk )"
RDEPEND="${DEPEND}"

DOCS=( README.i8kutils )

src_prepare() {
	sed \
		-e '/^CC/d' \
		-e '/^CFLAGS/d' \
		-e 's: -g : $(LDFLAGS) :g' \
		-i Makefile || die

	tc-export CC
}

src_install() {
	dobin i8kbuttons i8kctl
	doman i8kbuttons.1 i8kctl.1
	dosym /usr/bin/i8kctl /usr/bin/i8kfan

	use examples && dodoc -r examples

	newinitd "${FILESDIR}"/i8k.init-r1 i8k
	newconfd "${FILESDIR}"/i8k.conf i8k

	if use tk; then
		dobin i8kmon
		doman i8kmon.1
		dodoc i8kmon.conf
	else
		cat >> "${ED}"/etc/conf.d/i8k <<- EOF
		# i8kmon disabled because the package was installed without USE=tk
		NOMON=1
		EOF
	fi

}
