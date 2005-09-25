# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/tuxzap-programs/tuxzap-programs-0.5.4.ebuild,v 1.1 2005/09/25 11:24:57 vapier Exp $

inherit multilib

MY_P=${PN/-/_}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="mpegtools package for manipulation of various MPEG file formats"
HOMEPAGE="http://www.metzlerbros.org/dvb/"
SRC_URI="http://www.metzlerbros.org/dvb/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="gtk"

DEPEND=">=media-libs/libdvb-0.2.1
	|| (
		>=sys-kernel/linux-headers-2.6.11-r2
		media-tv/linuxtv-dvb
	)
	dev-libs/cdk
	gtk? ( =x11-libs/gtk+-1.2* )"

src_compile() {
	local myconf=""
	# not using X use var because gtk is needed too anyway
	use gtk || myconf="${myconf} --without-x"
	econf \
		--with-dvb-path=/usr/$(get_libdir) \
		--with-dvb-driver-path=/usr/include/libdvb \
		${myconf} || die
	emake || die 'compile failed'
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README AUTHORS NEWS ChangeLog
}
