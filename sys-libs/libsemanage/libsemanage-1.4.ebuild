# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libsemanage/libsemanage-1.4.ebuild,v 1.3 2006/01/14 00:53:26 spb Exp $

IUSE=""

SEPOL_VER="1.10"
SELNX_VER="1.28"

inherit eutils multilib

DESCRIPTION="SELinux kernel and policy management library"
HOMEPAGE="http://www.nsa.gov/selinux"
SRC_URI="http://www.nsa.gov/selinux/archives/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~mips ~ppc ~sparc ~x86"

DEPEND="=sys-libs/libsepol-${SEPOL_VER}*
	=sys-libs/libselinux-${SELNX_VER}*"

src_unpack() {
	unpack ${A}
	cd ${S}

	# make portage CFLAGS work
	sed -i -e "s:-Wall:-Wall ${CFLAGS}:g" ${S}/src/Makefile \
		|| die "src Makefile CFLAGS fix failed."

	# fix up paths for multilib
	sed -i -e "/^LIBDIR/s/lib/$(get_libdir)/" ${S}/src/Makefile \
		|| die "Fix for multilib LIBDIR failed."
	sed -i -e "/^SHLIBDIR/s/lib/$(get_libdir)/" ${S}/src/Makefile \
		|| die "Fix for multilib SHLIBDIR failed."
}

src_compile() {
	emake || die
}

src_install() {
	make DESTDIR="${D}" install

	# remove config file.  the appropriate
	# policy will install this file.
	rm -fR ${D}/etc
}
