# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kbeam/kbeam-0.61-r1.ebuild,v 1.3 2006/09/28 17:45:13 deathwing00 Exp $

inherit kde autotools

KLV="14683"
DESCRIPTION="A KDE application that lets you send and receive files to devices, using your Infrared port."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=${KLV}"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
SLOT="0"

DEPEND=">=dev-libs/openobex-1.1"

RDEPEND="${DEPEND}"

PATCHES="${FILESDIR}/${P}-aclocal_openobex.patch"

need-kde 3.2

src_unpack() {
	kde_src_unpack

	#need it for using the AM_PATH_OPENOBEX definition installed in system
	eaclocal && eautoconf || die "eaclocal or eautoconf has failed"
}
