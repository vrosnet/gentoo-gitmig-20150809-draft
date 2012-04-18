# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/cgal/cgal-4.0.ebuild,v 1.1 2012/04/18 23:46:24 bicatali Exp $

EAPI=4
CMAKE_BUILD_TYPE=Release
inherit base multilib cmake-utils

MY_P=CGAL-${PV}
PID=30385
DPID=30389

DESCRIPTION="C++ library for geometric algorithms and data structures"
HOMEPAGE="http://www.cgal.org/"
SRC_URI="http://gforge.inria.fr/frs/download.php/${PID}/${MY_P}.tar.xz
	doc? ( http://gforge.inria.fr/frs/download.php/${DPID}/${MY_P}-doc_html.tar.xz )"

LICENSE="LGPL-3 GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+cxx doc examples +gmp lapack mpfi qt4"

RDEPEND="dev-libs/boost
	dev-libs/mpfr
	sys-libs/zlib
	x11-libs/libX11
	virtual/opengl
	gmp? ( dev-libs/gmp[cxx=] )
	lapack? ( virtual/lapack )
	qt4? ( x11-libs/qt-gui:4
		x11-libs/qt-opengl:4 )
	mpfi? ( sci-libs/mpfi )"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

DOCS="AUTHORS CHANGES* README"

src_prepare() {
	base_src_prepare
	sed -i \
		-e '/install(FILES AUTHORS/d' \
		CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs
	if use gmp; then
		mycmakeargs+=( $(cmake-utils_use_with cxx GMPXX) )
	else
		mycmakeargs+=( "-DWITH_GMPXX=OFF" )
	fi
	mycmakeargs+=(
		"-DCGAL_INSTALL_LIB_DIR=$(get_libdir)"
		"-DWITH_CGAL_Qt3=OFF"
		"-DWITH_LEDA=OFF"
		$(cmake-utils_use_with examples)
		$(cmake-utils_use_with examples demos)
		$(cmake-utils_use_with gmp)
		$(cmake-utils_use_with qt4 CGAL_Qt4)
		$(cmake-utils_use_with mpfi)
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	use doc && dohtml -r "${WORKDIR}"/doc_html/cgal_manual/*
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
