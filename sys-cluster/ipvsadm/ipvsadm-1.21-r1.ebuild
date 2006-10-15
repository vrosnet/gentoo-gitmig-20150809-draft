# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/ipvsadm/ipvsadm-1.21-r1.ebuild,v 1.12 2006/10/15 11:43:26 xmerlin Exp $

inherit linux-info

PATCHLEVEL="11"
MY_PV="${PV}-${PATCHLEVEL}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="ipvsadm is a utility to administer the IP virtual server services offered by the Linux kernel with IP virtual server support."
HOMEPAGE="http://linuxvirtualserver.org"
LICENSE="GPL-2"
DEPEND="virtual/libc
	virtual/linux-sources
	>=sys-libs/ncurses-5.2"

SRC_URI="http://www.linuxvirtualserver.org/software/kernel-2.4/${MY_P}.tar.gz"

SLOT="0"
KEYWORDS="~ppc ~ppc64 x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if kernel_is 2 6; then
		eerror "${P} does not support 2.6 kernels, please try ${PN}-1.24"
		die "wrong kernel version"
	fi
}

src_compile() {
	emake || die "error compiling source"
}

src_install() {
	into /
	dosbin ipvsadm ipvsadm-save ipvsadm-restore || die

	doman ipvsadm.8 ipvsadm-save.8 ipvsadm-restore.8

	exeinto /etc/init.d
	newexe ${FILESDIR}/ipvsadm-init ipvsadm || die
	keepdir /var/lib/ipvsadm

	diropts -m 755 -o root -g root
	dodir /usr/lib
	dodir /usr/include/ipvs

	insopts -m 644 -o root -g root
	insinto /usr/lib
	doins libipvs/libipvs.a || die

	insinto /usr/include/ipvs
	newins libipvs/libipvs.h ipvs.h || die

	einfo "You will need a kernel that has ipvs patches to use LVS"
}
