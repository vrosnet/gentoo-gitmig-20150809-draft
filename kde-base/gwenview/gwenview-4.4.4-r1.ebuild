# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/gwenview/gwenview-4.4.4-r1.ebuild,v 1.4 2010/06/27 09:35:09 fauli Exp $

EAPI="3"

KMNAME="kdegraphics"
inherit kde4-meta

DESCRIPTION="KDE image viewer"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~ppc64 ~sparc x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook kipi semantic-desktop"

# tests hang, last checked for 4.2.96
RESTRICT="test"

DEPEND="
	$(add_kdebase_dep kdelibs 'semantic-desktop?')
	>=media-gfx/exiv2-0.18
	media-libs/jpeg
	kipi? ( $(add_kdebase_dep libkipi) )
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-4.4.4-jpeg.patch"
)

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with semantic-desktop Soprano)
		$(cmake-utils_use_with kipi)
	)

	if use semantic-desktop; then
		mycmakeargs+=(-DGWENVIEW_SEMANTICINFO_BACKEND=Nepomuk)
	else
		mycmakeargs+=(-DGWENVIEW_SEMANTICINFO_BACKEND=None)
	fi

	kde4-meta_src_configure
}

pkg_postinst() {
	kde4-meta_pkg_postinst

	echo
	elog "For SVG support, emerge -va kde-base/svgpart"
	echo
}
