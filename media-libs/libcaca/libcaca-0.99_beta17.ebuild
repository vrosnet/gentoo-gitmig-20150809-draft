# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libcaca/libcaca-0.99_beta17.ebuild,v 1.3 2010/07/22 08:20:57 ssuominen Exp $

EAPI=2
inherit libtool mono multilib java-pkg-opt-2

MY_P=${P/_/.}

DESCRIPTION="A library that creates colored ASCII-art graphics"
HOMEPAGE="http://libcaca.zoy.org/"
SRC_URI="http://libcaca.zoy.org/files/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2 ISC LGPL-2.1 WTFPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="cxx doc imlib java mono ncurses opengl ruby slang static-libs truetype X"

RDEPEND="imlib? ( media-libs/imlib2 )
	java? ( >=virtual/jre-1.5 )
	mono? ( dev-lang/mono )
	ncurses? ( >=sys-libs/ncurses-5.3 )
	opengl? ( virtual/opengl
		media-libs/freeglut
		truetype? ( >=media-libs/ftgl-2.1.3_rc5 ) )
	ruby? ( virtual/ruby )
	slang? ( >=sys-libs/slang-2 )
	X? ( x11-libs/libX11 x11-libs/libXt )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen
		virtual/latex-base
		|| ( dev-texlive/texlive-fontsrecommended app-text/ptex ) )
	java? ( >=virtual/jdk-1.5 )"

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -i \
		-e 's:-g -O2 -fno-strength-reduce -fomit-frame-pointer::' \
		configure || die

	if ! use truetype; then
		sed -i -e '/PKG_CONFIG/s:ftgl:dIsAbLe&:' configure || die
	fi

	elibtoolize
}

src_configure() {
	export VARTEXFONTS="${T}/fonts" #44128

	econf \
		--disable-dependency-tracking \
		$(use_enable static-libs static) \
		$(use_enable slang) \
		$(use_enable ncurses) \
		$(use_enable X x11) $(use_with X x) --x-libraries=/usr/$(get_libdir) \
		$(use_enable opengl gl) \
		$(use_enable mono csharp) \
		$(use_enable java) \
		$(use_enable cxx) \
		$(use_enable ruby) \
		$(use_enable imlib imlib2) \
		$(use_enable doc)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS NOTES README THANKS
	find "${D}" -name '*.la' -delete
}
