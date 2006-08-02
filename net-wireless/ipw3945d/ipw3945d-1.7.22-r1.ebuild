# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/ipw3945d/ipw3945d-1.7.22-r1.ebuild,v 1.1 2006/08/02 12:16:29 phreak Exp $

DESCRIPTION="Regulatory daemon for the Intel PRO/Wireless 3945ABG miniPCI express adapter"

HOMEPAGE="http://www.bughost.org/ipw3945/"
SRC_URI="http://www.bughost.org/ipw3945/daemon/${P}.tgz"

LICENSE="ipw3945"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND=""

src_install() {
	into /
	use x86 && dosbin x86/ipw3945d
	use amd64 && dosbin x86_64/ipw3945d

	insinto /etc/modules.d/
	newins "${FILESDIR}"/${PN}-1.7.18-modprobe.conf ${PN}

	dodoc README.ipw3945d
}

pkg_postinst() {
	echo
	einfo "A hook has been installed into the modprobe configuration in order to have"
	einfo "the regulatory daemon automatically launched upon loading the ipw3945 driver."
	einfo "You must run 'modules-update' for this hook to take affect."
	echo
}
