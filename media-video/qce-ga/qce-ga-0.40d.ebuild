# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/qce-ga/qce-ga-0.40d.ebuild,v 1.4 2003/08/03 03:14:58 vapier Exp $

DESCRIPTION="Logitech USB Quickcam Express Linux Driver Modules"
HOMEPAGE="http://qce-ga.sourceforge.net/"
SRC_URI="mirror://sourceforge/qce-ga/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/linux-sources"

pkg_setup() {
	[ -z "$KV" ] && die "Couldn't detect kernel version.  Does /usr/src/linux exist?"
	return 0
}

src_compile() {
	emake || die
}

src_install() {
	# install the driver in the right palce
	insinto "/lib/modules/${KV}/misc"
	doins mod_quickcam.o
	
	# install the READMEs and License
	dodoc README License
}

pkg_postinst() {
	if [ "${ROOT}" = "/" ]; then
		/sbin/update-modules
	fi
}	       
