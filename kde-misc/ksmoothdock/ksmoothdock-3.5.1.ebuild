# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/ksmoothdock/ksmoothdock-3.5.1.ebuild,v 1.5 2005/01/13 03:14:15 weeve Exp $

inherit kde eutils

DESCRIPTION="KSmoothDock is a dock program for KDE with smooth parabolic zooming."
HOMEPAGE="http://ksmoothdock.sourceforge.net"
SRC_URI="mirror://sourceforge/ksmoothdock/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc ~amd64"
IUSE=""

need-kde 3.2

src_unpack() {
	kde_src_unpack

	use arts || epatch ${FILESDIR}/${P}-configure-arts.patch
}

