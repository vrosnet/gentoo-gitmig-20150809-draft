# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/aespipe/aespipe-2.3b.ebuild,v 1.1 2005/06/18 05:15:39 avenj Exp $

DESCRIPTION="Encrypts data from stdin to stdout."
HOMEPAGE="http://loop-aes.sourceforge.net"
SRC_URI="http://loop-aes.sourceforge.net/aespipe/${PN}-v${PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE="static"
DEPEND=""
S="${WORKDIR}/${PN}-v${PV}"

src_compile() {
	use static && export LDFLAGS="-static -s"

	econf || die

	if [ "${ARCH}" == "x86" ]; then
		emake i586 || die
	else
		emake || die
	fi
}
src_install() {
	dobin aespipe
	dobin bz2aespipe
	dodoc README
	doman aespipe.1
}
