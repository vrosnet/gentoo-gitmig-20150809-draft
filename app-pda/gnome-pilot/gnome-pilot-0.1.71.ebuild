# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/gnome-pilot/gnome-pilot-0.1.71.ebuild,v 1.7 2005/05/17 17:13:35 liquidx Exp $


DESCRIPTION="Gnome Pilot apps"
SRC_URI="mirror://gnome/sources/gnome-pilot/${PV:0:3}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/gnome-pilot/"

RDEPEND="dev-lang/perl
	=gnome-base/control-center-1.4*
	>=gnome-base/gnome-libs-1.4.1.7
	=gnome-base/gnome-panel-1.4*
	>=app-pda/pilot-link-0.11.0
	=dev-util/gob-1*
	=gnome-base/libglade-0.17*"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

IUSE="nls"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc ppc"

src_unpack() {

	unpack ${A}
	cd ${S}
	# USB patch from Mandrake.  Allows gnome-pilot to watch /dev/pilot even
	# when it does not yet exist (because of using devfs).
	epatch ${FILESDIR}/gnome-pilot-0.1.70-usb.patch
	#epatch ${FILESDIR}/gnome-pilot-0.1.71-logmacro.patch
}

src_compile() {

	local myconf

#	use gtk2 \
#		&& CFLAGS="${CFLAGS} `pkg-config --cflags libglade vfs`" \
#		|| CFLAGS="${CFLAGS} `gtk-config --prefix`"

	use nls \
		&& myconf="--enable-nls" \
		|| myconf="--disable-nls"

	myconf="${myconf} --enable-usb --with-gnome-libs=/usr/lib"


	mkdir intl && touch intl/libgettext.h

	econf ${myconf} || die


	emake || die
}

src_install () {
	einstall || die

	dodoc AUTHORS COPYING* ChangeLog README NEWS
}
