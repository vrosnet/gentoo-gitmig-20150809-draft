# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/vmoconv/vmoconv-1.0-r1.ebuild,v 1.1 2009/03/03 19:37:50 mrness Exp $

inherit eutils autotools

DESCRIPTION="A tool that converts Siemens phones VMO and VMI audio files to gsm and wav."
HOMEPAGE="http://triq.net/obex/"
SRC_URI="http://triq.net/obexftp/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-sound/gsm"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/${P}-glibc28.patch"
	epatch "${FILESDIR}/${P}-flags.patch"
	epatch "${FILESDIR}/${P}-external-libgsm.patch"

	eautoreconf
}

src_install() {
	dobin src/vmo2gsm src/gsm2vmo src/vmo2wav
	dodoc AUTHORS ChangeLog NEWS README THANKS
}
