# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/bmp-midi/bmp-midi-0.01.ebuild,v 1.1 2004/12/20 21:44:48 chainsaw Exp $

IUSE=""

DESCRIPTION="Timidity++ Dependent MIDI Plugin for BMP"
HOMEPAGE="http://www.sosdg.org/~larne/w/Plugin_list"
SRC_URI="http://mitglied.lycos.de/mldoering/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="media-sound/beep-media-player
	media-sound/timidity++"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -si "s:xmms/plugin.h:beep-media-player/bmp/plugin.h:" mid.h
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING NEWS README
}

pkg_postinst() {
	ewarn "This plugin can not deal with multi-track MIDI files, this will segfault BMP."
	echo
	einfo "You need to place a working timidity.cfg in /etc; timidity-config will normally"
	einfo "arrange for this if you emerge timidity-eawpatches."
	ewarn "MIDI files will play silently if this condition is not met."
}
