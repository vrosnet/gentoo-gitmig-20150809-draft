# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/tftp-hpa/tftp-hpa-0.40-r1.ebuild,v 1.2 2005/04/28 01:36:16 vapier Exp $

DESCRIPTION="port of the OpenBSD TFTP server"
SRC_URI="mirror://kernel/software/network/tftp/${P}.tar.bz2"
HOMEPAGE="http://www.kernel.org/pub/software/network/tftp/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~sparc ~x86 ~s390"
IUSE=""

DEPEND="!virtual/tftp"
PROVIDE="virtual/tftp"

src_install() {
	make INSTALLROOT="${D}" install || die
	dodoc README* CHANGES INSTALL*

	# iputils installs this
	rm -f "${D}"/usr/share/man/man8/tftpd.8

	newconfd "${FILESDIR}"/in.tftpd.confd in.tftpd
	newinitd "${FILESDIR}"/in.tftpd.rc6 in.tftpd
}
