# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/came/came-1.9.ebuild,v 1.1 2005/07/17 11:07:37 vapier Exp $

inherit eutils

DESCRIPTION="rewrite of the xawtv webcam app, which adds imlib2 support and a lot of new features"
HOMEPAGE="http://linuxbrit.co.uk/camE/"
SRC_URI="http://linuxbrit.co.uk/downloads/camE-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=net-misc/curl-7.9.1
	>=media-libs/giblib-1.2.3"

S=${WORKDIR}/camE-${PV}

src_compile() {
	emake || die
}

src_install() {
	dobin camE || die
	dodoc AUTHORS camE_text.style camE_title.style example.camErc example.camErc.ssh
}
