# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/uade/uade-0.91.ebuild,v 1.4 2004/09/01 06:26:37 mr_bones_ Exp $

DESCRIPTION="Unix Amiga Delitracker Emulator - plays old Amiga tunes through UAE emulation and cloned m68k-assembler Eagleplayer API"
HOMEPAGE="http://uade.ton.tut.fi/"
SRC_URI="http://uade.ton.tut.fi/uade/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="xmms sdl alsa oss perl"

RDEPEND="virtual/libc
	xmms? (
		>=media-sound/xmms-1.2.2
		x11-libs/gtk+ )
	sdl? ( media-libs/libsdl )
	alsa? ( >=media-libs/alsa-lib-1.0.5 )"

DEPEND="${RDEPEND}
	xmms? ( sys-devel/libtool )"

src_compile() {
	./configure \
		--prefix=/usr \
		--package-prefix="${D}" \
		--docdir="/usr/share/doc/${PF}" \
		--without-bmp \
		$(use_with oss) \
		$(use_with sdl) \
		$(use_with alsa) \
		$(use_with xmms) \
		|| die "configure failed"
	emake || die 'emake failed'
}

src_install() {
	make DESTDIR="${D}" install || die 'make install failed'
	dodoc BUGS ChangeLog.txt FIXED ANTIPLANS README PLANS TESTING docs/CREDITS

	find "${D}/usr/share/doc/${PF}/" \
		\( -name '*.readme'	-o \
		-name '*.txt'		-o \
		-name 'INSTALL*'	-o \
		-name 'README*'		-o \
		-name 'Change*' \) -exec gzip -9 \{\} \;
	dohtml -r "${D}/usr/share/doc/${PF}/"
	rm -f "${D}/usr/share/doc/${PF}/"{COPYING,INSTALL.*.gz}
	rm -f "${D}/usr/share/doc/${PF}/uade-docs/"{*.html,*.png,*.1}

	if ! use perl; then
		rm -f "${D}/usr/bin/pwrap.pl"
	fi
}
