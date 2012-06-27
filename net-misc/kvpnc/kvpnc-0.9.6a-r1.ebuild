# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/kvpnc/kvpnc-0.9.6a-r1.ebuild,v 1.2 2012/06/27 18:56:23 dilfridge Exp $

EAPI=3
KDE_LINGUAS="ar br cs da de el en_GB eo es et eu fr ga gl hi hne it ja ka lt
ms nb nds nl nn pa pl pt pt_BR ro ru sv tr uk zh_CN zh_TW"
inherit kde4-base

DESCRIPTION="KDE frontend for various VPN clients"
HOMEPAGE="http://home.gna.org/kvpnc/"
SRC_URI="http://download.gna.org/kvpnc/${P}-kde4.tar.bz2
	http://download.gna.org/kvpnc/${P/a}-kde4-locale.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="
	dev-libs/libgcrypt
"
DEPEND="${RDEPEND}
	sys-devel/gettext
"

S=${WORKDIR}/${P}-kde4

PATCHES=(
	"${FILESDIR}/${P}-scriptsec.patch"
	"${FILESDIR}/${P}-gcc47.patch"
)

src_prepare() {
	mv -vf "${WORKDIR}"/${P/a}-kde4-locale/po . || die

	echo "find_package ( Msgfmt REQUIRED )" >> CMakeLists.txt
	echo "find_package ( Gettext REQUIRED )" >> CMakeLists.txt
	echo "add_subdirectory ( po )" >> CMakeLists.txt

	sed -i \
		-e "s:0.9.2-svn:${PV}:" \
		CMakeLists.txt || die

	kde4-base_src_prepare
}

src_configure() {
	mycmakeargs=( "-DWITH_libgcrypt=ON" )
	kde4-base_src_configure
}
