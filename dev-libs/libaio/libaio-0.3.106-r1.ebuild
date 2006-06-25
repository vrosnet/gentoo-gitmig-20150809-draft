# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libaio/libaio-0.3.106-r1.ebuild,v 1.3 2006/06/25 09:42:27 dertobi123 Exp $

inherit eutils multilib

DESCRIPTION="Asynchronous input/output library that uses the kernels native interface"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/andrea/libaio/"
# Rip out of src rpm that Redhat uses:
# http://download.fedora.redhat.com/pub/fedora/linux/core/development/SRPMS/
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ppc ppc64 ~s390 ~x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.3.104-build.patch
}

src_install() {
	make prefix="${D}/usr" libdir="${D}/usr/$(get_libdir)" install || die
	doman man/*
	dodoc ChangeLog TODO

	# remove stuff provided by man-pages now
	rm "${D}"/usr/share/man/man3/aio_{cancel,error,fsync,read,return,suspend,write}.*
}
