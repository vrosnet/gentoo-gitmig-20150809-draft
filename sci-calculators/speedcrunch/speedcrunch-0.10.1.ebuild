# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/speedcrunch/speedcrunch-0.10.1.ebuild,v 1.4 2012/08/04 21:52:55 bicatali Exp $

EAPI=4

inherit eutils cmake-utils

DESCRIPTION="A fast and usable calculator for power users"
HOMEPAGE="https://code.google.com/p/speedcrunch/"
SRC_URI="http://speedcrunch.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux"
IUSE="doc"

DEPEND="x11-libs/qt-gui:4"
RDEPEND="${DEPEND}"

LANGS="ca cs de en es es_AR eu fi fr he id it nb nl no pl
	pt pt_BR ro ru sv tr zh_CN"
for lang in ${LANGS}; do
	IUSE="${IUSE} linguas_${lang}"
done

S="${WORKDIR}/${P}/src"

src_prepare( ) {
	epatch "${FILESDIR}"/${P}-iconname.patch
	# regenerate translations
	lrelease speedcrunch.pro || die
	local lang
	for lang in ${LANGS}; do
		if ! use linguas_${lang}; then
			sed -i -e "s:i18n/${lang}\.qm::" Translations.cmake || die
			sed -i -e "s:books/${lang}::" CMakeLists.txt || die
		fi
	done
}

src_install() {
	cmake-utils_src_install
	cd ..
	dodoc ChangeLog ChangeLog.floatnum HACKING.txt LISEZMOI README TRANSLATORS
	use doc && dodoc doc/*.pdf
}
