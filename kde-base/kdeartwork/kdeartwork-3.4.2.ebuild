# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork/kdeartwork-3.4.2.ebuild,v 1.3 2005/07/30 14:07:33 danarmak Exp $

inherit kde-dist eutils

DESCRIPTION="KDE artwork package"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE="opengl xscreensaver"

DEPEND="~kde-base/kdebase-${PV}
	media-libs/libart_lgpl
	opengl? ( virtual/opengl )
	xscreensaver? ( x11-misc/xscreensaver )"

src_unpack() {
	kde_src_unpack

	# Configure patch. Applied for 3.5.
	epatch ${FILESDIR}/kdeartwork-3.4-configure.patch

	# For the configure patch.
	make -f admin/Makefile.common
}

src_compile() {
	local myconf="--with-dpms --with-libart
	              $(use_with opengl gl)"

	if use xscreensaver; then
		myconf="${myconf} --with-xscreensaver
		        --with-xscreensaver-dir=/usr/lib/misc/xscreensaver
		        --with-xscreensaver-config=/usr/share/xscreensaver/config"
	else
		myconf="${myconf} --without-xscreensaver"
	fi

	kde_src_compile
}
