# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <blutgens@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-crypt/seahorse/seahorse-0.5.0.ebuild,v 1.7 2001/10/06 23:17:53 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnome front end to gnupg"
SRC_URI="http://download.sourceforge.net/seahorse/${A}"
HOMEPGAE="http://seahorse.sourceforge.net/"

DEPEND="virtual/glibc virtual/x11
	>=app-crypt/gnupg-1.0.4
	>=gnome-base/gnome-libs-1.4.1.2-r1"

src_compile() {                           
	./configure --host=${CHOST}					\
		    --prefix=/usr
	assert

	emake || die
}

src_install() {
	make DESTDIR=${D}						\
	     localedir=${D}/usr/share/locale 				\
	     gnulocaledir=${D}/usr/share/locale install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
