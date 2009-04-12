# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ifenslave/ifenslave-1.1.0-r4.ebuild,v 1.1 2009/04/12 20:44:06 robbat2 Exp $

inherit toolchain-funcs eutils

DESCRIPTION="Attach and detach slave interfaces to a bonding device"
HOMEPAGE="http://sf.net/projects/bonding/"
MY_PN="ifenslave-2.6" # this is NOT an error
DEBIAN_PV="12"
DEBIANPKG_TARBALL="${MY_PN}_${PV}.orig.tar.gz"
DEBIANPKG_PATCH="${MY_PN}_${PV}-${DEBIAN_PV}.diff.gz"
DEBIANPKG_BASE="mirror://debian/pool/main/${MY_PN:0:1}/${MY_PN}"
SRC_URI="${DEBIANPKG_BASE}/${DEBIANPKG_TARBALL}
		 ${DEBIANPKG_BASE}/${DEBIANPKG_PATCH}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
RDEPEND="virtual/libc"
DEPEND="sys-devel/gcc
		>=sys-kernel/linux-headers-2.4.22
		${RDEPEND}"

src_unpack() {
	unpack ${DEBIANPKG_TARBALL}
	EPATCH_OPTS="-d ${S} -p1" epatch ${DISTDIR}/${DEBIANPKG_PATCH}
}

src_compile() {
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} ${PN}.c -o ${PN} || die "Failed to compile!"
}

src_install() {
	doman ${S}/${PN}.8
	into /
	dosbin ${PN}
	# there really is no better documentation than the sourcecode :-)
	dodoc ${PN}.c
	insinto /etc/modprobe.d
	newins ${FILESDIR}/modules.d-bond-1.1.0-r3 bond
}

pkg_preinst() {
	if [[ -a /etc/modules.d/bond ]] && [[ ! -a /etc/modprobe.d/bond ]]; then
		elog "Moving old bond configuration in modules.d to new"
		elog "location in modprobe.d in /etc/"
		mv "${ROOT}/etc/modules.d/bond" "${ROOT}/etc/modprobe.d/bond"
	fi
}

pkg_postinst() {
	einfo "If you want to use bonding on your system, be sure to use"
	einfo ">=baselayout-1.10, where support is now integrated!"
	einfo "Using >=baselayout-1.11.6 strongly recommended."
}
