# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt-svg/qt-svg-4.4.0_beta1.ebuild,v 1.1 2008/03/05 23:12:19 ingmar Exp $

inherit qt4-build

DESCRIPTION="The SVG module for the Qt toolkit."
HOMEPAGE="http://www.trolltech.com/"

LICENSE="|| ( QPL-1.0 GPL-3 GPL-2 )"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="~x11-libs/qt-gui-${PV}"
RDEPEND="${DEPEND}"

QT4_TARGET_DIRECTORIES="
src/svg
src/plugins/imageformats/svg
src/plugins/iconengines/svgiconengine"

src_compile() {
	local myconf
	myconf="${myconf} -no-xkb -no-tablet -no-fontconfig -no-xrender -no-xrandr
		-no-xfixes -no-xcursor -no-xinerama -no-xshape -no-sm -no-opengl
		-no-nas-sound -no-qdbus -iconv -no-cups -no-nis -no-gif -no-libpng
		-no-libmng -no-libjpeg -no-openssl -system-zlib -no-webkit -no-phonon
		-no-qt3support -no-xmlpatterns -no-freetype -no-libtiff -no-accessibility
		-no-fontconfig -no-glib -no-opengl"

	qt4-build_src_compile
}
