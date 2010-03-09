# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/irrlicht/irrlicht-1.6.1.ebuild,v 1.2 2010/03/09 06:27:40 ssuominen Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION="open source high performance realtime 3D engine written in C++"
HOMEPAGE="http://irrlicht.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

RDEPEND="media-libs/jpeg
	media-libs/libpng
	virtual/opengl
	virtual/glu
	x11-libs/libX11"
DEPEND="${RDEPEND}
	app-arch/unzip
	x11-proto/xproto
	x11-proto/xf86vidmodeproto"

S=${WORKDIR}/${P}/source/Irrlicht

src_prepare() {
	cd "${WORKDIR}"/${P}
	epatch \
		"${FILESDIR}"/${P}-config.patch \
		"${FILESDIR}"/${P}-demoMake.patch

	sed -i \
		-e 's:\.\./\.\./media:../media:g' \
		$(grep -rl '\.\./\.\./media' examples) \
		|| die 'sed failed'

	cd "${S}"
	sed -i \
		-e '/^CXXFLAGS/s:=:+=:' \
		-e '/^CXXINCS/s:-Izlib -Ijpeglib -Ilibpng::' \
		-e '/^ZLIBOBJ/d' \
		-e '/^JPEGLIBOBJ/d' \
		-e '/^LIBPNGOBJ/d' \
		Makefile || die "sed failed"

	sed -i \
		-e 's:png_set_gray_1_2_4_to_8:png_set_expand_gray_1_2_4_to_8:' \
		CImageLoaderPNG.cpp || die
}

src_compile() {
	emake CXX="$(tc-getCXX)" || die "emake failed"
}

src_install() {
	cd ../..
	dolib.a lib/Linux/libIrrlicht.a || die "dolib.a failed"
	insinto /usr/include/${PN}
	doins include/* || die "doins failed"
	dodoc changes.txt readme.txt
	if use doc ; then
		insinto /usr/share/doc/${PF}
		doins -r examples media || die "doins failed"
	fi
}
