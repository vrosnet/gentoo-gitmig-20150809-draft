# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/xbox-sources/xbox-sources-2.6.8.1-r8.ebuild,v 1.2 2005/01/02 18:17:26 chrb Exp $

ETYPE='sources'
inherit kernel-2
detect_version

# version of gentoo patchset
XBOX_PATCHES=xboxpatches-2.6.8.1-20041104-r1.tar.bz2

K_NOSETEXTRAVERSION="don't_set_it"
KEYWORDS="~x86 -*"
UNIPATCH_LIST="
	${DISTDIR}/${XBOX_PATCHES}
	${DISTDIR}/linux-${OKV}-CAN-2004-0814.patch
	${FILESDIR}/${PN}-2.6.7.cmdlineLeak.patch
	${FILESDIR}/${P}.devPtmx.patch
	${FILESDIR}/${P}.smbfs.patch
	${FILESDIR}/${P}.binfmt_elf.patch
	${FILESDIR}/${P}.binfmt_a.out.patch
	${FILESDIR}/${P}.AF_UNIX.patch
	${FILESDIR}/${P}.AF_UNIX.SELinux.patch
	${FILESDIR}/${P}.CAN-2004-1016.patch
	${FILESDIR}/${P}.CAN-2004-1056.patch
	${FILESDIR}/${P}.CAN-2004-1137.patch
	${FILESDIR}/${P}.CAN-2004-1151.patch
	${FILESDIR}/${P}.vma.patch"
DESCRIPTION='Full sources for the Xbox Linux kernel'
SRC_URI="${KERNEL_URI}
	mirror://gentoo/${XBOX_PATCHES}
	http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/linux-${OKV}-CAN-2004-0814.patch"

pkg_postinst() {
	einfo ''
	einfo 'WARNING: The FATX driver is currently horribly broken. Writing to a FATX partition with this kernel will corrupt it.'
	einfo ''
}
