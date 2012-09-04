# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kactivities/kactivities-4.9.1.ebuild,v 1.1 2012/09/04 18:45:31 johu Exp $

EAPI=4

inherit kde4-base

DESCRIPTION="KDE Activity Manager"

KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="semantic-desktop"

DEPEND="$(add_kdebase_dep kdelibs 'semantic-desktop=')"
RDEPEND="${DEPEND}"

# Split out from kdelibs in 4.7.1-r2
add_blocker kdelibs 4.7.1-r1
# Moved here in 4.8
add_blocker activitymanager

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with semantic-desktop Nepomuk)
	)
	kde4-base_src_configure
}
