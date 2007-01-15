# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/euses/euses-2.5.4.ebuild,v 1.7 2007/01/15 01:31:50 metalgod Exp $

inherit toolchain-funcs autotools

WANT_AUTOCONF="latest"

DESCRIPTION="look up USE flag descriptions fast"
HOMEPAGE="http://www.xs4all.nl/~rooversj/gentoo"
SRC_URI="http://www.xs4all.nl/~rooversj/gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc x86 ~x86-fbsd"
IUSE=""

S="${WORKDIR}"

src_unpack() {
	cd "${S}"
	unpack "${A}"
	eautoreconf
}

src_install() {
	dobin ${PN} || die
	doman ${PN}.1 || die
	dodoc ChangeLog || die
}
