# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kbrain/kbrain-0.1.3.ebuild,v 1.2 2005/02/25 01:38:45 weeve Exp $

inherit kde
need-kde 3

PATCHES="${FILESDIR}/${P}-gentoo.diff"
IUSE=""
DESCRIPTION="handy program to create Mind Maps"
SRC_URI="http://cmjartan.freezope.org/kbrain/files/${P}.tar.gz"
HOMEPAGE="http://cmjartan.freezope.org/kbrain"

LICENSE="GPL-2"
KEYWORDS="x86 ~amd64 ~sparc"
